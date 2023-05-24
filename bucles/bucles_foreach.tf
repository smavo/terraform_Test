# -------------------------
# Define el provider de AWS
# -------------------------
provider "aws" {
  region = "eu-west-1"
}

variable "usuarios_3" {
  description = "Nombre usuarios IAM"
  type        = set(string)
  default = ["Martin", "Yadira", "Fernando"]
}

resource "aws_iam_user" "user_3" {
  for_each = var.usuarios_3

  name = "user-iam-${each.value}"
}


# Output de Salida
output "arn_usuario_3" {
  value = aws_iam_user.user_3["Martin"].arn
}

output "nombre_a_arn_3" {
  value = { for usuario in aws_iam_user.user_3 : usuario.name => usuario.arn }
}

output "nombres_usuarios_3" {
  value = [for usuario in aws_iam_user.user_3 : usuario.name]
}