
locals {
  region          = "us-east-1"
  ami             = var.ubuntu_ami[local.region]
  puerto_lb       = 80        # module "load_balancer"
  puerto_servidor = 8080      # module "load_balancer"
  entorno = "dev"
}
