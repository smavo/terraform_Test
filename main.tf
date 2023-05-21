# Define el provider de aws
provider "aws" {
  region = "us-east-1"
  access_key = "AKIAUXW453BIR5JRYL64"
  secret_key = "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"
}

# Define la instancia EC2 
resource "aws_instance" "servidor_smavo"{
    ami = "ami-053b0d53c279acc90"
    instance_type = "t2.micro"
        tags = {
        Name = "Instancia de prueba en test terraform"
        Enviroment = "Desarrollo"
        Manager = "Terraform"
    }
}