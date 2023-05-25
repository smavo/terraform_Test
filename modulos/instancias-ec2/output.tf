
output "instancia_ids" {
  description = "IDs de las instancias"
  value       = [for servidor in aws_instance.servidor : servidor.id]
}

output "dns_publica_servidores" {
  description = "DNS pública de los servidores creados"
  value       = [for servidor in aws_instance.servidor : "http://${servidor.public_dns}:${var.puerto_servidor}"]
}


output "ipv4_servidores" {
    description = "IPv4 de nuestros servidores creados"
    value = [for servidor in aws_instance.servidor : "IP Servidor: ${servidor.public_ip}" ]
}
