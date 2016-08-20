resource "aws_instance" "couchbase_primary" {
  # Primary data node, wait to startup until all secondary nodes are loaded

  depends_on = [
    "aws_instance.couchbase_data",
    "aws_instance.couchbase_index",
    "aws_instance.couchbase_query",
    "aws_instance.couchbase_fts"
  ]

  ami               = "${var.ami}"
  instance_type     = "${var.data_instancetype}"
  key_name          = "${var.keypairname}"

  subnet_id              = "${var.subnet_id}"
  private_ip             = "${cidrhost(var.subnet_cidr, var.couchbase_data_ipstart)}"
  vpc_security_group_ids = [
    "${aws_security_group.couchbase.id}"
  ]

  iam_instance_profile    = "${var.iam_instance_profile}"
  disable_api_termination = "${var.termination_protection}"
  monitoring              = "${var.detailed_monitoring}"
  ebs_optimized           = "${var.data_ebsoptimized}"

  user_data = "${data.template_file.userdata_primary.rendered}"

  root_block_device {
    volume_type = "${var.boot_volumetype}"
    volume_size = "${var.boot_volumesize}"
    iops        = "${var.boot_volumeiops}"
  }

  ebs_block_device {
    device_name = "/dev/sdb"
    volume_type = "${var.data_volumetype}"
    volume_size = "${var.data_volumesize}"
    iops        = "${var.data_volumeiops}"
    encrypted   = "${var.volume_encryption}"
    delete_on_termination = "${var.volume_delete_on_termination}"
  }

  tags {
    Name = "${var.name_prefix} Data 1"
  }

  lifecycle {
    ignore_changes = [
      "user_data",
      "iam_instance_profile",
      "key_name"
    ]
  }
}
