output "dns_publica" {
    description = "DNS Publica del servidor"
    value = "http://${aws_instance.servidor_smavo}:8080"
}

output "ipv4_servidor" {
    description = "IPv4 de nuestro servidor"
    value = aws_instance.servidor_smavo.public_ip
}