# Variables relacionadas con la infraestructura de red
variable "vpc_id" {
  description = "ID de la VPC donde se desplegarán los recursos. Define el espacio de red en el que las instancias y otros servicios de AWS estarán operando."
  type        = string
}

variable "tags" {
  description = "Etiquetas clave-valor para organizar y clasificar los recursos de AWS. Pueden usarse para filtrado y gestión de costos."
  type        = map(string)
}