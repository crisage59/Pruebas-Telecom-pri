
resource "aws_security_group" "this" {
  name   = "${var.tags.Environment}-${var.tags.Site}-sg"
  vpc_id = var.vpc_id # Cambia al ID de tu VPC

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] # Cambia según tus necesidades de seguridad
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1" # Permitir todo el tráfico de salida
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = var.tags
}