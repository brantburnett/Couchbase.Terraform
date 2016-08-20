resource "aws_instance" "couchbase_query" {
  # Query nodes

  count = "${var.query_nodes}"

  ami               = "${var.ami}"
  instance_type     = "${var.data_instancetype}"
  key_name          = "${var.keypairname}"
  tenancy           = "${var.tenancy}"

  subnet_id              = "${var.subnet_id}"
  private_ip             = "${cidrhost(var.subnet_cidr, var.couchbase_query_ipstart + count.index)}"
  vpc_security_group_ids = [
    "${aws_security_group.couchbase.id}"
  ]

  iam_instance_profile    = "${var.iam_instance_profile}"
  disable_api_termination = "${var.termination_protection}"
  monitoring              = "${var.detailed_monitoring}"
  ebs_optimized           = "${var.query_ebsoptimized}"

  user_data = "${data.template_file.userdata_base.rendered}"

  root_block_device {
    volume_type = "${var.boot_volumetype}"
    volume_size = "${var.boot_volumesize}"
    iops        = "${var.boot_volumeiops}"
  }

  ebs_block_device {
    device_name = "/dev/sdb"
    volume_type = "${var.query_volumetype}"
    volume_size = "${var.query_volumesize}"
    iops        = "${var.query_volumeiops}"
    encrypted   = "${var.volume_encryption}"
    delete_on_termination = "${var.volume_delete_on_termination}"
  }

  tags {
    Name = "${var.name_prefix} Query ${count.index + 1}"
  }

  lifecycle {
    ignore_changes = [
      "user_data",
      "iam_instance_profile",
      "key_name"
    ]
  }
}

# Note: Technically using resources instead of data for templates is deprecated
# However, data doesn't support "count" yet, so we still need to use resources

resource "template_file" "attach_query" {
  count = "${var.query_nodes}"
  template = "${file("${path.module}/attach.tpl")}"

  vars {
    cluster_password = "${var.cluster_password}"
    server_ip = "${element(aws_instance.couchbase_query.*.private_ip, count.index)}"
    server_password = "${element(aws_instance.couchbase_query.*.id, count.index)}"
    services = "query"
  }
}
