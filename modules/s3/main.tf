resource "aws_s3_bucket" "this" {
  bucket = "${var.tags.Environment}-${var.tags.Site}-static"
  tags   = var.tags
}