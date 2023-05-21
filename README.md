# Terraform

### Instalacion Terraform Ubuntu 
```wget -O- https://apt.releases.hashicorp.com/gpg | sudo gpg --dearmor -o /usr/share/keyrings/hashicorp-archive-keyring.gpg

echo "deb [signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] https://apt.releases.hashicorp.com $(lsb_release -cs) main" | sudo tee /etc/apt/sources.list.d/hashicorp.list

sudo apt update && sudo apt install terraform
```

### Crear usuario terraform_user en aws
* IAM / Users / Add Users / 
    - User name: terraform_user (no seleccionar ningun tipo) / Next
    - Seleccionar **Attach policies directly** / 
    - Agregar el permiso: **AdministratorAccess** / Next / Create USer

    - Regresar a la vista de todos los usaurios / Seleccionamos el usuario creado
    - Nos dirigimos a la seccion **Security credentials**
    - Nos vamos a la seccion **Access keys** /  **Create access key**
    - Seleccionar **Command Line Interface (CLI)** / Marcar la seccion **I understand the above recommendation and want to proceed to create an access key.** / Next
    - Description tag value, Agregar un nombre de tag / click en el boton **Create access Key**
    - Ver las credenciales y descargarlo en csv. 


### Instalacion CLI AWS en Ubuntu 
```curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
unzip awscliv2.zip
sudo ./aws/install
```


### Configurar CLI AWS 
aws configure

* Te pedira ingresar el usuario y la clave (estos estan en el archivo.csv que descargaste)


### Validar Configuracion del CLI en Ubuntu
`aws sts get-caller-identity`


## Comandos 
* Inicializa la configuración de Terraform
`terraform init`

* Validacion de la configuracion
`terraform validate`

* Toma la configuracion para generar un plan de ejecución
`terraform plan`

* Ejecuta el plan de ejecucion y crea la infraestructura 
`terraform apply` 

* Elimina la infraestructura gestionada por Terraform
`terraform destroy`

* Instalar graphviz dot
`sudo apt install graphviz`

* Crear imagen de la configuracion de terrform
`terraform graph > base2.dot`

* Comando para la Imagen de configuracion
`terraform graph | dot -Tsvg > base2.svg`


### Enviroments Variables
export AWS_ACCESS_KEY_ID="access_key"
export AWS_SECRET_ACCESS_KEY="secret_key"
export AWS_REGION="region_name"

### validar variables de entorno
env

### Eliminar archivos al volver a crear la configuracion de Terraform
rm -rf .terraform
rm terraform.tfstate
rm terraform.tfstate.backup 
rm .terraform.lock.hcl 

### Ejecucion de Comando en secuencia
terraform init && terraform validate && terraform plan 
terraform graph > base3.dot && terraform graph | dot -Tsvg > base3.svg

