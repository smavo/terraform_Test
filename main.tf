# --------------------------
# Define el provider de aws
provider "aws" {
  region = local.region
}

# --------------------------
# Data Source del ID de la VPC por defecto
data "aws_vpc" "default" {
  default = true
}

# --------------------------
# Data Source obtiene el ID del AZ us-east-1c, us-east-1b, us-east-1a
data "aws_subnet" "public_subnet" {
  for_each = var.servidores

  availability_zone = "${local.region}${each.value.az}"
}

# --------------------------
# Creacion de Instancias EC2
resource "aws_instance" "servidores_ec2" {
  for_each = var.servidores

  ami                    = local.ami
  instance_type          = var.instanceType
  subnet_id              = data.aws_subnet.public_subnet[each.key].id
  vpc_security_group_ids = [aws_security_group.mi_sg.id]
  tags = {
    Name       = each.value.nombre
    Enviroment = each.value.az
    Manager    = "Terraform"
  }

  user_data = <<-EOF
              #!/bin/bash
              sudo su
              apt get update
              apt get install -y busybox-static 
              echo "Hola Terraformers! Soy ${each.value.nombre}" > index.html
              nohup busybox httpd -f -p ${var.puerto_servidor} & 
              EOF
}


# --------------------------
# Define un grupo de seguridad con acceso al puerto 8080
resource "aws_security_group" "mi_sg" {
  name   = "server_security_group_A"
  vpc_id = data.aws_vpc.default.id

  ingress {
    # cidr_blocks = ["0.0.0.0/0"]
    security_groups = [aws_security_group.alb_sg.id]
    description     = "Acceso al puerto 8080 desde el exterior"
    from_port       = var.puerto_servidor
    to_port         = var.puerto_servidor
    protocol        = "TCP"
  }
}

# --------------------------
# Load Balancer publico para N instancias
resource "aws_lb" "albApplicacion" {
  load_balancer_type = "application"
  name               = "terraform-alb"
  security_groups    = [aws_security_group.alb_sg.id]
  subnets            = [for subnet in data.aws_subnet.public_subnet : subnet.id]
}

# --------------------------
# Define un grupo de seguridad con acceso al puerto 80
resource "aws_security_group" "alb_sg" {
  name   = "alb_security_group"
  vpc_id = data.aws_vpc.default.id

  ingress {
    cidr_blocks = ["0.0.0.0/0"]
    description = "Acceso al puerto 80 desde el exterior"
    from_port   = var.puerto_lb
    to_port     = var.puerto_lb
    protocol    = "TCP"
  }

  egress {
    cidr_blocks = ["0.0.0.0/0"]
    description = "Acceso al puerto 8080 desde el exterior"
    from_port   = var.puerto_servidor
    to_port     = var.puerto_servidor
    protocol    = "TCP"
  }

}

# --------------------------
# Target Group para el Load Balancer
resource "aws_lb_target_group" "targetThis" {
  name     = "terraform-alb-targetGroup"
  port     = var.puerto_lb
  vpc_id   = data.aws_vpc.default.id
  protocol = "HTTP"

  health_check {
    enabled  = true
    matcher  = "200"
    path     = "/"
    port     = "8080"
    protocol = "HTTP"
  }

}

# --------------------------
# Attachment para N Servidores 
resource "aws_lb_target_group_attachment" "servidores" {
  for_each = var.servidores

  target_group_arn = aws_lb_target_group.targetThis.arn
  target_id        = aws_instance.servidores_ec2[each.key].id
  port             = var.puerto_servidor
}


# --------------------------
# Listener para el LB
resource "aws_lb_listener" "listenerThis" {
  load_balancer_arn = aws_lb.albApplicacion.arn
  port              = var.puerto_lb
  # protocol = "HTTP"

  default_action {
    target_group_arn = aws_lb_target_group.targetThis.arn
    type             = "forward"
  }

}
