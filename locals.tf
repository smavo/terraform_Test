locals {
  region = "us-east-1"
  ami    = var.ubuntu_ami[local.region]
}