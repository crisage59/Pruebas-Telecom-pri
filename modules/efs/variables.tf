# Variables relacionadas con Elastic File System (EFS)
variable "efs_id" {
  description = "ID del sistema de archivos EFS. Se utiliza para montar el sistema de archivos compartido en las instancias EC2."
  type        = string
}

variable "tags" {
  description = "Etiquetas clave-valor para organizar y clasificar los recursos de AWS. Pueden usarse para filtrado y gestión de costos."
  type        = map(string)
}