# Couchbase.Terraform
Terraform modules for establishing a Couchbase cluster

## Cluster Types
Currently, these types of clusters have been implemented:

- [Amazon AWS using Ubuntu 14.04](aws/ubuntu14.04/README.md)

## How To Use
The scripts may be referenced using Terraform Modules.  For details on modules, see [the Terraform documentation](https://www.terraform.io/docs/modules/index.html).  The module may be referenced directly from GitHub, or you can make a local copy into a subfolder.

Variables passed to the module control the created cluster.  For a variable reference, see the `variables.tf` file for the cluster type you are creating.

Each cluster type also contains a `README.md` file with instructions and examples.