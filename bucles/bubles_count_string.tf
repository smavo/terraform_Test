# -------------------------
# Define el provider de AWS
# -------------------------
provider "aws" {
  region = "us-west-1"
}

# ---------------------------------
# Define número de usuarios a crear
# ---------------------------------
variable "usuarios_1" {
  description = "Nombre de usuarios IAM"
  type        = list(string)
  default = ["Sergio", "Yadira"]
}


# ---------------------------------
# Crea un <var.usuarios> de IAM
# ---------------------------------
resource "aws_iam_user" "user_2" {
  count = length(var.usuarios_1)

  name = "user-string-${var.usuarios_1[count.index]}"
}
