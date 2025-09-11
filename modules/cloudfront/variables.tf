variable "origin_id" {
  description = "ID de la VPC origen desde la cual se harán las conexiones o asociaciones, en caso de ser necesaria una referencia a otra infraestructura."
  type        = string
}

variable "s3_bucket_regional_domain_name" {
  description = ""
  type        = string
}


variable "acm_certificate_arn" {
  description = ""
  type = string
}

variable "tags" {
  description = "Etiquetas clave-valor para organizar y clasificar los recursos de AWS. Pueden usarse para filtrado y gestión de costos."
  type        = map(string)
}

 variable "waf_id" {
   type = string
   default = ""
 }

variable "allowed_countries" {
  type = list(string)
}