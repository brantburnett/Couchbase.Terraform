# AWS using Ubuntu 14.04

## Key Variables

For a full variable reference, see [variables.tf](variables.tf).  Here are some of the key variables:

| Variable | Required | Description |
| -------- |:--------:| ----------- |
| cluster_password | Y | Password for the Couchbase cluster |
| keypairname | Y | Name of the EC2 key pair to create the instances |
| ami | Y | ID of the Ubuntu 14.04 AMI to use |
| vpc_id | Y | ID of the VPC the cluster will be created within |
| subnet_id | Y | ID of the subnet the cluster will be created within |
| subnet_cidr | Y | CIDR of the subnet, i.e. "10.1.0.0/24" |
| access_cidr | Y | List of subnets allowed to access the Couchbase cluster, i.e. ["10.1.0.0/24", 10.1.1.0/24"] |
| ssh_cidr | Y | List of subnets allowed to access the Couchbase cluster via SSH, i.e. ["10.1.0.0/24", 10.1.1.0/24"] |
| installer_url | N | URL to download the Couchbase installer.  By default, downloads 4.5 Enterprise from couchbase.com. |
| data_nodes | N | Number of data nodes, minimum of 1, default of 2 |
| index_nodes | N | Number of index nodes, default of 1 |
| query_nodes | N | Number of query nodes, default of 1 |
| fts_nodes | N | Number of full text search nodes, default of 0 |
| additional_initialization_script | N | Additional Linux script to run on the primary node after the cluster is initialized.  This might create buckets, or setup XDCR, etc.

## Example

The following example creates a basic cluster in the 10.0.1.0/24 subnet of a VPC.  Normally, you would probably replace the specific identifiers shown with references to their Terraform resources.

To create more than one cluster (for example, for XDCR), simply reference the module more than once.

```terraform
provider "aws" {
  access_key = "<your_access_key>"
  secret_key = "<your_secret_key>"
  region     = "us-east-1"
}

data "aws_ami" "couchbase" {
  most_recent = true

  filter {
    name = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-trusty-14.04-amd64-server-*"]
  }

  owners = ["099720109477"]
}

module "couchbase" {
  source = "github.com/brantburnett/Couchbase.Terraform/aws/ubuntu14.04"

  ami         = "${data.aws_ami.couchbase.id}"
  vpc_id      = "vpc-ec8ef78b"
  subnet_id   = "subnet-13b9a52e"
  subnet_cidr = "10.0.1.0/24"
  ssh_cidr    = ["10.0.0.0/16"]
  access_cidr = ["10.0.0.0/16"]

  cluster_password = "password"
  keypairname      = "keypair"

  data_nodes  = 3
  query_nodes = 1
  index_nodes = 1
  fts_nodes   = 1
}

```

To run:

1. Update `vpc_id`, `subnet_id`, `subnet_cidr`, `ssh_cidr`, and `access_cidr` based on your VPC
2. Update `keypairname` with the name of your EC2 key pair
3. Run `terraform get` - downloads Git repository
4. Run `terraform apply` - creates the cluster
