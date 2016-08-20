resource "aws_security_group" "couchbase" {
  name            = "Couchbase"
  description     = "Inbound connections for Couchbase"
  vpc_id          = "${var.vpc_id}"

  # SSH
  ingress {
    from_port = 22
    to_port = 22
    protocol = "tcp"
    cidr_blocks = "${var.ssh_cidr}"
  }

  # General client ports
  ingress {
    from_port = 8091
    to_port = 8094
    protocol = "tcp"
    cidr_blocks = "${var.access_cidr}"
  }

  # Erland port mapper
  ingress {
    from_port = 4369
    to_port = 4369
    protocol = "tcp"
    cidr_blocks = "${var.access_cidr}"
  }

  # Internal index ports
  ingress {
    from_port = 9100
    to_port = 9105
    protocol = "tcp"
    cidr_blocks = ["${var.subnet_cidr}"]
  }

  # Internal REST
  ingress {
    from_port = 9998
    to_port = 9998
    protocol = "tcp"
    cidr_blocks = "${var.access_cidr}"
  }

  # Internal GSI
  ingress {
    from_port = 9999
    to_port = 9999
    protocol = "tcp"
    cidr_blocks = ["${var.subnet_cidr}"]
  }

  # SSL memcached
  ingress {
    from_port = 11207
    to_port = 11207
    protocol = "tcp"
    cidr_blocks = "${var.access_cidr}"
  }

  # Internal bucket port
  ingress {
    from_port = 11209
    to_port = 11209
    protocol = "tcp"
    cidr_blocks = ["${var.subnet_cidr}"]
  }

  # Direct node connection and Moxi
  ingress {
    from_port = 11210
    to_port = 11211
    protocol = "tcp"
    cidr_blocks = "${var.access_cidr}"
  }

  # SSL XDCR
  ingress {
    from_port = 11214
    to_port = 11215
    protocol = "tcp"
    cidr_blocks = "${var.access_cidr}"
  }

  # General SSL client ports
  ingress {
    from_port = 18091
    to_port = 18093
    protocol = "tcp"
    cidr_blocks = "${var.access_cidr}"
  }

  # Node data exchange
  ingress {
    from_port = 21100
    to_port = 21299
    protocol = "tcp"
    cidr_blocks = ["${var.subnet_cidr}"]
  }

  egress {
    from_port = 0
    to_port = 0
    protocol = -1
    cidr_blocks = ["0.0.0.0/0"]
  }
}
