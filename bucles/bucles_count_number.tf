# -------------------------
# Define el provider de AWS
# -------------------------
/* provider "aws" {
  region = "eu-west-1"
}  */

variable "usuarios_2" {
  description = "Nombre de usuarios IAM"
  type = number
  default = 3
}

# ---------------------------------
# Crea un <var.usuarios> de IAM
# ---------------------------------
resource "aws_iam_user" "usuarios_2" {
  count = var.usuarios_2
  
  name = "user-number.${count.index}"
}

# Outputs de Salida
output "arn_usuario_2" {
  value = aws_iam_user.usuarios_2[2].arn
}

output "arn_todos_usuarios_2" {
  # value = [for usuario in aws_iam_user.usuarios_2 : usuario.arn]
  value = aws_iam_user.usuarios_2[*].arn
}
