output "dns_publica_servidores" {
  description = "DNS pública de los servidores"
  value       = [for servidor in aws_instance.servidores_ec2 : "http://${servidor.public_dns}:${var.puerto_servidor}"]
}

output "dns_load_balancer" {
  description = "DNS pública del load balancer"
  value       = "http://${aws_lb.albApplicacion.dns_name}:${var.puerto_lb}"
}


output "ipv4_servidores" {
    description = "IPv4 de nuestros servidores"
    value = [for servidor in aws_instance.servidores_ec2 : "IP Servidor: ${servidor.public_ip}" ]
}



