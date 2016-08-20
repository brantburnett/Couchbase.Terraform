data "template_file" "userdata_base" {
  template = "${file("${path.module}/userdata_base.tpl")}"

  vars {
    installer_url = "${var.installer_url}"
  }
}

data "template_file" "userdata_primary" {
  template = "${file("${path.module}/userdata_primary.tpl")}"

  vars {
    userdata_base = "${data.template_file.userdata_base.rendered}"
    cluster_password = "${var.cluster_password}"
    data_ramsize = "${var.data_ramsize}"
    index_ramsize = "${var.index_ramsize}"
    fts_ramsize = "${var.fts_ramsize}"
    attach_servers = "${join("", concat(template_file.attach_data.*.rendered, template_file.attach_index.*.rendered, template_file.attach_query.*.rendered, template_file.attach_fts.*.rendered))}"
    additional_initialization_script = "${var.additional_initialization_script}"
  }
}
