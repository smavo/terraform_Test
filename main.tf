# --------------------------
# Define el provider de aws
provider "aws" {
  region = var.region
}

# --------------------------
# Data Source del ID de la VPC por defecto
data "aws_vpc" "default" {
  default = true
}

# --------------------------
# Data Source obtiene el ID del AZ 1
data "aws_subnet" "az_c"{
  availability_zone = "us-east-1c"
}

# --------------------------
# Data Source obtiene el ID del AZ 2
data "aws_subnet" "az_b"{
  availability_zone = "us-east-1b"
}

# --------------------------
# Instancia EC2 - Primera Instancia
resource "aws_instance" "servidor_smavo_I"{
    ami = var.ubuntu_ami["us-east-1"]
    instance_type = var.instanceType
    subnet_id = data.aws_subnet.az_b.id
    vpc_security_group_ids = [ aws_security_group.mi_sg.id ]
    tags = {
      Name = "Instancia EC2 en terraform I"
      Enviroment = "Desarrollo A"
      Manager = "Terraform"
    }
    user_data = "${file("user-data-apache.sh")}"
}

# --------------------------
# Instancia EC2 - Segunda Instancia
resource "aws_instance" "servidor_smavo_II"{
    ami = var.ubuntu_ami["us-east-1"]
    instance_type = var.instanceType
    subnet_id = data.aws_subnet.az_c.id
    vpc_security_group_ids = [ aws_security_group.mi_sg.id ]
    tags = {
      Name = "Instancia EC2 en terraform II"
      Enviroment = "Desarrollo B"
      Manager = "Terraform"
    }
    user_data = "${file("user-data-apache.sh")}"
}

# --------------------------
# Define un grupo de seguridad con acceso al puerto 8080
resource "aws_security_group" "mi_sg" {            
  name = "primer_server_sg"
  vpc_id = data.aws_vpc.default.id
  
  ingress {
    # cidr_blocks = ["0.0.0.0/0"]
    security_groups = [aws_security_group.alb_sg.id]
    description = "Acceso al puerto 8080 desde el exterior"
    from_port = var.puerto_servidor
    to_port = var.puerto_servidor
    protocol = "TCP"
  }
}

# --------------------------
# Load Balancer publico para 2 instancias
resource "aws_lb" "albApplicacion" {
  load_balancer_type = "application"
  name = "terraform-alb"
  security_groups = [aws_security_group.alb_sg.id]
  subnets = [data.aws_subnet.az_b.id, data.aws_subnet.az_c.id]
}

# --------------------------
# Define un grupo de seguridad con acceso al puerto 80
resource "aws_security_group" "alb_sg" {            
  name = "alb_security_group"
  vpc_id = data.aws_vpc.default.id
  
  ingress {
    cidr_blocks = ["0.0.0.0/0"]
    description = "Acceso al puerto 80 desde el exterior"
    from_port = var.puerto_lb
    to_port = var.puerto_lb
    protocol = "TCP"
  }

  egress {
    cidr_blocks = ["0.0.0.0/0"]
    description = "Acceso al puerto 8080 desde el exterior"
    from_port = var.puerto_servidor
    to_port = var.puerto_servidor
    protocol = "TCP"
  }

}

# --------------------------
# Target Group para el Load Balancer
resource "aws_lb_target_group" "targetThis" {
  name = "terraform-alb-targetGroup"
  port = var.puerto_lb
  vpc_id = data.aws_vpc.default.id
  protocol = "HTTP"

  health_check {
    enabled = true
    matcher = "200"
    path = "/"
    port = "8080"
    protocol = "HTTP"
  }

}

# --------------------------
# Attachment para el servidor 1 
resource "aws_lb_target_group_attachment" "server_1" {
  target_group_arn = aws_lb_target_group.targetThis.arn
  target_id = aws_instance.servidor_smavo_I.id
  port = var.puerto_servidor
}

# --------------------------
# Attachment para el servidor 2
resource "aws_lb_target_group_attachment" "server_2" {
  target_group_arn = aws_lb_target_group.targetThis.arn
  target_id = aws_instance.servidor_smavo_II.id
  port = var.puerto_servidor
}

# --------------------------
# Listener para el LB
resource "aws_lb_listener" "listenerThis" {
  load_balancer_arn = aws_lb.albApplicacion.arn
  port = var.puerto_lb
  # protocol = "HTTP"

  default_action {
    target_group_arn = aws_lb_target_group.targetThis.arn
    type = "forward"
  }

}