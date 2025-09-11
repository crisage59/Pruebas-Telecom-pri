# Variables relacionadas con la aplicación y certificado
variable "app" {
  description = "Nombre de la aplicación asociada al certificado. Usado para identificar los recursos relacionados con un certificado de seguridad."
  type        = string
}

variable "tags" {
  description = "Etiquetas clave-valor para organizar y clasificar los recursos de AWS. Pueden usarse para filtrado y gestión de costos."
  type        = map(string)
}