# Define el provider de aws
provider "aws" {
  region = var.region
  access_key = "AKIAUXW453BIR5JRYL64"
  secret_key = "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"
}

# Define la instancia EC2 
resource "aws_instance" "servidor_smavo"{
    ami = var.ami
    instance_type = "t2.micro"
        tags = {
        Name = "Instancia de prueba en test terraform"
        Enviroment = "Desarrollo"
        Manager = "Terraform"
    }
}