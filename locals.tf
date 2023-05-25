
locals {
  region          = "us-east-1"
  ami             = var.ubuntu_ami[local.region]
  puerto_lb       = 80
  puerto_servidor = 8080
}
