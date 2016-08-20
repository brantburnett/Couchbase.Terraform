# Prefix used on EC2 instance names
variable "name_prefix" {
  default = "Couchbase"
}

# Password for the Couchbase cluster
variable "cluster_password" {}

# Name of the EC2 key pair to create the instances
variable "keypairname" {}

# URL for installer to download and install on each instance
variable "installer_url" {
  default = "http://packages.couchbase.com/releases/4.5.0/couchbase-server-enterprise_4.5.0-ubuntu14.04_amd64.deb"
}


# ID of the Ubuntu 14.04 AMI to use
variable "ami" {}

# ID of the VPC the cluster will be created within
variable "vpc_id" {}

# ID of the subnet the cluster will be created within
variable "subnet_id" {}

# CIDR of the subnet, i.e. "10.1.0.0/24"
variable "subnet_cidr" {}

# List of subnets allowed to access the Couchbase servers
variable "access_cidr" {
  type = "list"
}

# Subnets allowed to SSH to the Couchbase servers
variable "ssh_cidr" {
  type = "list"
}

# IAM instance profile to apply IAM roles
variable "iam_instance_profile" {
  default = ""
}

# If true, prevents accidental termination
variable "termination_protection" {
  default = false
}

# If true, turns on detailed CloudWatch monitoring (additional cost)
variable "detailed_monitoring" {
  default = false
}

# Indicates instance host tenancy, "default" or "dedicated"
variable "tenancy" {
  default = "default"
}

# Type of the boot volume for all node types, such as "gp2" or "io1"
variable "boot_volumetype" {
  default = "gp2" # SSD, no provisioned IOPS
}

# Size of the boot volume for all node types, in GB
variable "boot_volumesize" {
  default = 10
}

# For "io1" volumes, the number of IOPS to provision for the boot volume of all node types
variable "boot_volumeiops" {
  default = 0
}

# Number of each type of node to create
variable "data_nodes" {
  default = 2
}
variable "index_nodes" {
  default = 1
}
variable "query_nodes" {
  default = 1
}
variable "fts_nodes" {
  default = 0
}

# Instance type for each type of node
variable "data_instancetype" {
  default = "m4.xlarge"
}
variable "index_instancetype" {
  default = "m4.xlarge"
}
variable "query_instancetype" {
  default = "m4.xlarge"
}
variable "fts_instancetype" {
  default = "m4.xlarge"
}

# Volume type for each type of node, such as "gp2" or "io1"
variable "data_volumetype" {
  default = "gp2" # SSD, no provisioned IOPS
}
variable "index_volumetype" {
  default = "gp2"
}
variable "query_volumetype" {
  default = "gp2"
}
variable "fts_volumetype" {
  default = "gp2"
}

# Volume size for each type of node, in gigabytes
variable "data_volumesize" {
  default = 300
}
variable "index_volumesize" {
  default = 300
}
variable "query_volumesize" {
  default = 100
}
variable "fts_volumesize" {
  default = 100
}

# For "io1" volumes, the number of IOPS to provision for each type of node
variable "data_volumeiops" {
  default = 0
}
variable "index_volumeiops" {
  default = 0
}
variable "query_volumeiops" {
  default = 0
}
variable "fts_volumeiops" {
  default = 0
}

# For each node type, indicates if the instance should be EBS optimized
# Note that some instance types include this feature, such as the m4 series
variable "data_ebsoptimized" {
  default = true
}
variable "index_ebsoptimized" {
  default = true
}
variable "query_ebsoptimized" {
  default = true
}
variable "fts_ebsoptimized" {
  default = true
}

# If true, secondary volumes will be encrypted for all node types
variable "volume_encryption" {
  default = false
}

# If true, secondary volumes will be deleted when the instance is terminated
variable "volume_delete_on_termination" {
  default = true
}

# RAM size for each type of node, in megabytes
variable "data_ramsize" {
  default = 10000
}
variable "index_ramsize" {
  default = 10000
}
variable "fts_ramsize" {
  default = 10000
}

# First IP address for each type of node.  Last segment only, it is combined with the subnet_cidr automatically.
variable "couchbase_data_ipstart" {
  default = 11
}
variable "couchbase_index_ipstart" {
  default = 51
}
variable "couchbase_query_ipstart" {
  default = 101
}
variable "couchbase_fts_ipstart" {
  default = 151
}

# Additonal Linux script to run after the cluster is initialized
# For example, it might create buckets or set other server settings
# Executes on the primary data node
variable "additional_initialization_script" {
  default = ""
}
