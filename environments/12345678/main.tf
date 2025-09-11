module "acm_virginia" {
    source = "../../modules/acm"
    app = var.app
    tags = var.tags
    providers = {
        aws = aws.virginia
    }
}

module "acm_ohio" {
    source = "../../modules/acm"
    app = var.app
    tags = var.tags
}

module "autoscaling" {
    source = "../../modules/autoscaling"
    app = var.app
    aeg_desired_capacity = var.aeg_desired_capacity
    aeg_max_size = var.aeg_max_size
    aeg_min_size = var.aeg_min_size
    image_id = var.image_id
    instance_type = var.instance_type
    launch_template_name = var.launch_template_name
    owner = var.owner
    role_profile = var.role_profile
    subnets_id = var.subnets_id
    tags = var.tags
    vpc_id = var.vpc_id
    efs_id = var.efs_id
    lb_suffix_arn = var.lb_suffix_arn
    lb_target_group_suffix_arn = module.lb.tg_suffix_arn
    ssm_parameter_id = module.parameter.id
    efs_access_point_id = module.efs.id
    security_group_id = module.sg.id
    lb_target_group_arn = module.lb.tg_arn
    lb_target_group_internal_arn = module.lb.tg_internal_arn
    lb_name = var.lb_name
    lb_target_group_name = module.lb.tg_name
}

module "cloudfront" {
      source = "../../modules/cloudfront"
      origin_id = var.origin_id
      s3_bucket_regional_domain_name = module.s3.bucket_regional_domain_name
      acm_certificate_arn = module.acm_virginia.arn
      allowed_countries = var.allowed_countries
      tags = var.tags

      waf_id = "arn:aws:wafv2:us-east-1:766028941436:global/webacl/wordpress-webacl-base/662d41b0-a2d3-48cd-9a98-1eaae0d3ed28"
  }

module "cognito" {
    source = "../../modules/cognito"
    tags = var.tags
    user_pool_id = var.user_pool_id
}

module "efs" {
    source = "../../modules/efs"
    efs_id = var.efs_id
    tags = var.tags
}

module "lb" {
    source = "../../modules/lb"
    alb_private = var.alb_private
    alb_public = var.alb_public
    listener_private = var.listener_private
    listener_public = var.listener_public
    vpc_id = var.vpc_id
    autoscaling_group_id = module.autoscaling.id
     user_pool_arn = var.user_pool_arn
     user_pool_client_id = module.cognito.id
     user_pool_domain = var.user_pool_domain
     acm_certificate_arn = module.acm_ohio.arn
    tags = var.tags
}

module "parameter" {
    source = "../../modules/parameter"
    app = var.app
}

module "s3" {
    source = "../../modules/s3"
    tags = var.tags
}

module "sg" {
    source = "../../modules/sg"
    vpc_id = var.vpc_id
    tags = var.tags
}


