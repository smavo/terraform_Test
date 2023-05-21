output "dns_publica_server_1" {
    description = "DNS Publica del servidor"
    value = aws_instance.servidor_smavo_I
}

output "dns_publica_server_2" {
    description = "DNS Publica del servidor"
    value = aws_instance.servidor_smavo_II
}


/* output "ipv4_servidor_1" {
    description = "IPv4 de nuestro servidor"
    value = aws_instance.servidor_smavo_I
} */
