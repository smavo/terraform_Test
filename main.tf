# Define el provider de aws
provider "aws" {
  region = var.region
}

# Data Source del ID dela VPC por defecto
data "aws_vpc" "default" {
  default = true
}

# Data Source obtiene el ID del AZ 1
data "aws_subnet" "az_c"{
  availability_zone = "us-east-1c"
}

# Data Source obtiene el ID del AZ 2
data "aws_subnet" "az_b"{
  availability_zone = "us-east-1b"
}

# Instancia EC2 - Primera Instancia
resource "aws_instance" "servidor_smavo_I"{
    ami = var.ami
    instance_type = "t2.micro"
    subnet_id = data.aws_subnet.az_b.id
    vpc_security_group_ids = [ aws_security_group.mi_sg.id ]
    tags = {
      Name = "Instancia EC2 en terraform I"
      Enviroment = "Desarrollo A"
      Manager = "Terraform"
    }
    user_data = "${file("user-data-apache.sh")}"
}

# Instancia EC2 - Segunda Instancia
resource "aws_instance" "servidor_smavo_II"{
    ami = var.ami
    instance_type = "t2.micro"
    subnet_id = data.aws_subnet.az_c.id
    vpc_security_group_ids = [ aws_security_group.mi_sg.id ]
    tags = {
      Name = "Instancia EC2 en terraform II"
      Enviroment = "Desarrollo B"
      Manager = "Terraform"
    }
    user_data = "${file("user-data-apache.sh")}"
}

# Define un grupo de seguridad con acceso al puerto 8080
resource "aws_security_group" "mi_sg" {            
  name = "primer_server_sg"
  vpc_id = data.aws_vpc.default.id
  ingress {
    cidr_blocks = ["0.0.0.0/0"]
    description = "Acceso al puerto 8080 desde el exterior"
    from_port = 8080
    to_port = 8080
    protocol = "TCP"
  }
}