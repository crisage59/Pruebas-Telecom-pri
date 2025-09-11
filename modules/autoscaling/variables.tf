# Variables relacionadas con Auto Scaling Group (ASG)
variable "aeg_desired_capacity" {
  description = "Número deseado de instancias en el Auto Scaling Group. Determina la cantidad de instancias que deberían estar en ejecución por defecto."
  type        = number
}

variable "aeg_max_size" {
  description = "Número máximo de instancias que pueden estar en el Auto Scaling Group. Limita el número de instancias que se pueden lanzar en función de la carga."
  type        = number
}

variable "aeg_min_size" {
  description = "Número mínimo de instancias que debe haber en el Auto Scaling Group. Garantiza que siempre haya un número mínimo de instancias en funcionamiento."
  type        = number
}


# Variables relacionadas con Instancias EC2 y Lanzamiento
variable "image_id" {
  description = "ID de la imagen de Amazon Machine Image (AMI) que se utilizará para crear las instancias EC2."
  type        = string
}

variable "instance_type" {
  description = "Tipo de instancia EC2 que se utilizará en el Auto Scaling Group y otras configuraciones. Determina la cantidad de recursos (CPU, RAM) disponibles."
  type        = string
}

variable "launch_template_name" {
  description = "Nombre del template de lanzamiento que define la configuración predeterminada de las instancias EC2, como AMI, tipo de instancia, etc."
  type        = string
}

# Variables generales
variable "owner" {
  description = "Nombre del propietario o responsable del dominio. Generalmente se refiere a la persona o equipo responsable del manejo de los recursos."
  type        = string
}

variable "role_profile" {
  description = "Perfil de rol asociado a las instancias EC2. Define los permisos necesarios para que la instancia acceda a otros recursos dentro de AWS."
  type        = string
}

variable "subnets_id" {
  description = "Lista de IDs de subredes donde se desplegarán las instancias. Especifica las subredes dentro de la VPC donde se ejecutarán los recursos."
  type        = list(string)
}

variable "tags" {
  description = "Etiquetas clave-valor para organizar y clasificar los recursos de AWS. Pueden usarse para filtrado y gestión de costos."
  type        = map(string)
}

# Variables relacionadas con la infraestructura de red
variable "vpc_id" {
  description = "ID de la VPC donde se desplegarán los recursos. Define el espacio de red en el que las instancias y otros servicios de AWS estarán operando."
  type        = string
}

# Variables relacionadas con Elastic File System (EFS)
variable "efs_id" {
  description = "ID del sistema de archivos EFS. Se utiliza para montar el sistema de archivos compartido en las instancias EC2."
  type        = string
}

# Variables relacionadas con la aplicación y certificado
variable "app" {
  description = "Nombre de la aplicación asociada al certificado. Usado para identificar los recursos relacionados con un certificado de seguridad."
  type        = string
}

variable "lb_suffix_arn" {
  description = ""
  type        = string
}

variable "lb_name" {
  type = string
}

variable "lb_target_group_suffix_arn" {
  description = ""
  type        = string
}

variable "lb_target_group_name" {
  description = ""
  type        = string
}

variable "lb_target_group_internal_arn" {
  description = ""
  type        = string
}

variable "lb_target_group_arn" {
  description = ""
  type        = string
}

variable "ssm_parameter_id" {
  description = ""
  type        = string
}

variable "efs_access_point_id" {
  type = string
}

variable "security_group_id" {
  type = string
}