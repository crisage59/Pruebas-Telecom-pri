variable "bucket_name" {
  description = "Nombre del bucket de S3"
  type        = string
  default     = "mi-bucket-de-prueba-terraform"
}


variable "aws_region" {
  description = "Región de AWS"
  type        = string
  default     = "us-east-1"
}

variable "environment" {
  description = "Entorno"
  type        = string
  default     = "test"
}
