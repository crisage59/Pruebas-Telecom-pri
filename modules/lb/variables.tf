
# Variables relacionadas con Load Balancers (ALB)
variable "alb_private" {
  description = "Dirección URL o nombre del balanceador de carga privado que manejará el tráfico interno de la VPC."
  type        = string
}

variable "alb_public" {
  description = "Dirección URL o nombre del balanceador de carga público que manejará el tráfico externo hacia la infraestructura."
  type        = string
}


# Variables relacionadas con Listener en ALB
variable "listener_private" {
  description = "Dirección URL o nombre del listener privado que recibe el tráfico interno en el balanceador de carga privado."
  type        = string
}

variable "listener_public" {
  description = "Dirección URL o nombre del listener público que recibe el tráfico externo en el balanceador de carga público."
  type        = string
}

# Variables relacionadas con la infraestructura de red
variable "vpc_id" {
  description = "ID de la VPC donde se desplegarán los recursos. Define el espacio de red en el que las instancias y otros servicios de AWS estarán operando."
  type        = string
}

# Variables generales
variable "tags" {
  description = "Etiquetas clave-valor para organizar y clasificar los recursos de AWS. Pueden usarse para filtrado y gestión de costos."
  type        = map(string)
}

variable "autoscaling_group_id" {
  description = ""
  type        = string
}

variable "user_pool_arn" {
  type = string
}

variable "user_pool_client_id" {
    type = string
}

variable "user_pool_domain" {
    type = string
}

variable "acm_certificate_arn" {
 type = string
}