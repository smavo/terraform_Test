output "dns_load_balancer" {
  description = "DNS pública del load balancer"
  value       = module.load_balancer.dns_load_balancer
}


output "dns_publica_servidores" {
  description = "DNS pública de los servidores creados"
  value       = module.servidores_ec2.dns_publica_servidores
}


output "ipv4_servidores" {
    description = "IPv4 de nuestros servidores creados"
    value       = module.servidores_ec2.ipv4_servidores
}
