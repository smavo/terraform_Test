# Define el provider de aws
provider "aws" {
  region = var.region
}

# Define la instancia EC2 
resource "aws_instance" "servidor_smavo"{
    ami = var.ami
    instance_type = "t2.micro"
    vpc_security_group_ids = [ aws_security_group.mi_sg.id ]
    tags = {
      Name = "Instancia EC2 en terraform"
      Enviroment = "Desarrollo"
      Manager = "Terraform"
    }
    user_data = "${file("user-data-apache.sh")}"
}

# Define un grupo de seguridad con acceso al puerto 8080
resource "aws_security_group" "mi_sg" {            
  name = "primer_server_sg"

  ingress {
    cidr_blocks = ["0.0.0.0/0"]
    description = "Acceso al puerto 8080 desde el exterior"
    from_port = 8080
    to_port = 8080
    protocol = "TCP"
  }
}