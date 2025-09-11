output "arn" {
  value = module.acm_ohio.arn
}

output "tg_suffix_arn" {
#   value = aws_lb_target_group.tg_wordpress.arn_suffix
    value = module.lb.tg_suffix_arn
}

output "tg_internal_suffix_arn" {
#   value = aws_lb_target_group.tg_wordpress.arn_suffix
    value = module.lb.tg_internal_suffix_arn
}

output "tg_name" {
  value = module.lb.tg_name
}

output "tg_internal_name" {
  value = module.lb.tg_internal_name
}

output "tg_arn" {
  value = module.lb.tg_arn
}

output "tg_internal_arn" {
  value = module.lb.tg_internal_arn
}