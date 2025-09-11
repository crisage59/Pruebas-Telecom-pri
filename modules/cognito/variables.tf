variable "tags" {
  description = "Etiquetas clave-valor para organizar y clasificar los recursos de AWS. Pueden usarse para filtrado y gestión de costos."
  type        = map(string)
}

variable "user_pool_id" {
  description = "Id del user pool de cognito"
  type = string
}