
variable "region"{
    type = string
    description ="Region en aws"
    default = "us-east-1"
}

variable "ubuntu_ami"{
    description ="Identificar de Ami por Region"
    type = map(string)

    default = {
        "us-east-1" = "ami-053b0d53c279acc90" 
        "us-east-2" = "ami-024e6efaf93d85776" 
    }
}

variable "servidores" {
  description = "Mapa de servidores con su correspondiente AZ"

  type = map(object({
    nombre = string,
    az     = string
    })
  )

  default = {
    "ser-1" = { nombre = "servidor-1", az = "a" },
    "ser-2" = { nombre = "servidor-2", az = "b" },
    "ser-3" = { nombre = "servidor-3", az = "c" }
  }
}

variable "instanceType"{
    type = string
    description ="Identificador del Tipo de Instancia"
    default = "t2.micro"
}

variable "puerto_servidor"{
    type = number
    description ="Identificador del Puerto del Servidor"
    default = 8080

    validation {
      condition = var.puerto_servidor > 0 && var.puerto_servidor <= 65536
      error_message = "Ingresar un puerto valido"
    }
}

variable "puerto_lb"{
    type = number
    description ="Identificador del Puerto para el Load Balancer"
    default = 80

    validation {
      condition = var.puerto_lb > 0 && var.puerto_lb <= 65536
      error_message = "Ingresar un puerto valido"
    }
}


/*  
    # us-east-1
    Ubuntu Server 22.04 LTS (HVM), SSD Volume Type
    ami-053b0d53c279acc90 (64 bits (x86)) / ami-0a0c8eebcdd6dcbd0 (64 bits (Arm))

    Ubuntu Server 20.04 LTS (HVM), SSD Volume Type
    ami-0261755bbcb8c4a84 (64 bits (x86)) / ami-097d5b19d4f1a7d1b (64 bits (Arm))

    # us-east-2
    Ubuntu Server 22.04 LTS (HVM), SSD Volume Type
    ami-024e6efaf93d85776 (64 bits (x86)) / ami-08fdd91d87f63bb09 (64 bits (Arm))

    Ubuntu Server 20.04 LTS (HVM), SSD Volume Type
    ami-0430580de6244e02e (64 bits (x86)) / ami-0071e4b30f26879e2 (64 bits (Arm))

*/
