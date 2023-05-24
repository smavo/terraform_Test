# -------------------------
# Define el provider de AWS
# -------------------------
/* provider "aws" {
  region = "eu-west-1"
} */

# ---------------------------------
# Crea un <var.usuarios> de IAM
# ---------------------------------
resource "aws_iam_user" "usuarios_2" {
  count = 2

  name = "user-number.${count.index}"
}
