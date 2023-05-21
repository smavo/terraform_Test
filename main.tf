# Define el provider de aws
provider "aws" {
  region = var.region
}

# Define la instancia EC2 
resource "aws_instance" "servidor_smavo"{
    ami = var.ami
    instance_type = "t2.micro"
        tags = {
        Name = "Instancia EC2 en terraform"
        Enviroment = "Desarrollo"
        Manager = "Terraform"
    }
}