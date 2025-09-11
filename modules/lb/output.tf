output "tg_suffix_arn" {
#   value = aws_lb_target_group.tg_wordpress.arn_suffix
    value = aws_lb_target_group.this.arn_suffix
}

output "tg_internal_suffix_arn" {
#   value = aws_lb_target_group.tg_wordpress.arn_suffix
    value = aws_lb_target_group.this-internal.arn_suffix
}

output "tg_name" {
  value = aws_lb_target_group.this.name
}

output "tg_internal_name" {
  value = aws_lb_target_group.this-internal.id
}

output "tg_arn" {
  value = aws_lb_target_group.this.arn
}

output "tg_internal_arn" {
  value = aws_lb_target_group.this-internal.arn
}