# -------------------------
# Define el provider de AWS
# -------------------------
/* provider "aws" {
  region = "eu-west-1"
} */

variable "usuarios_3" {
  description = "Nombre usuarios IAM"
  type        = set(string)
  default = ["Martin", "Yadira", "Fernando"]
}

resource "aws_iam_user" "user_3" {
  for_each = var.usuarios_3

  name = "user-iam-${each.value}"
}
