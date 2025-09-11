resource "aws_acm_certificate" "this" {
  domain_name       = "${var.tags.Site}.cba.gov.ar"
  validation_method = "DNS"

  subject_alternative_names = [
    "${var.tags.Site}.cba.gov.ar"
  ]

  tags = var.tags
}
