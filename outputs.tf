output "dns_publica_server_1" {
    description = "DNS Publica del servidor 1"
    value = "http://${aws_instance.servidor_smavo_I.public_dns}:${var.puerto_servidor}"
}

output "ipv4_servidor_1" {
    description = "IPv4 de nuestro servidor_1"
    value = aws_instance.servidor_smavo_I.public_ip
}


output "dns_publica_server_2" {
    description = "DNS Publica del servidor 2"
    value = "http://${aws_instance.servidor_smavo_II.public_dns}:${var.puerto_servidor}"
}

output "ipv4_servidor_2" {
    description = "IPv4 de nuestro servidor_2"
    value = aws_instance.servidor_smavo_II.public_ip
}


output "dns_load_balancer" {
    description = "DNS Pública del load balancer"
    value = "http://${aws_lb.albApplicacion.dns_name}::${var.puerto_lb}"
}


