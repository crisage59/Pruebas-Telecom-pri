#### CAMBIA POR SITIOS
app   = "talentotech"

aeg_desired_capacity = "1"
aeg_max_size         = "3"
aeg_min_size         = "1"

tags = {
  Terraform   = "true"
  Site        = "talentotech"
  Environment = "prod"
  Cuenta      = "msp-aws"
  Module      = "msp-aws"
  Ambiente    = "Prod"
  Entidad      = "MinEco"
  Dependencia  = "Megp"
  Aplicacion = "ec2"
}


#### NO CAMBIA POR SITIOS
owner = "talentotech"
instance_type = "t3a.small"
image_id      = "ami-08ae89377b6832e10"
subnets_id    = ["subnet-0925d185db089a905"]
vpc_id        = "vpc-0be8646ca8294d51a"
role_profile  = "ssm_profile-20221220145140703400000004"

alb_public = "arn:aws:elasticloadbalancing:us-east-2:766028941436:loadbalancer/app/prod-frontweb-alb/2fc0b6e04a61c114"
alb_private  = "arn:aws:elasticloadbalancing:us-east-2:766028941436:loadbalancer/app/prod-alb/b9a4e7755f5ca7ea"

listener_private = "arn:aws:elasticloadbalancing:us-east-2:766028941436:listener/app/prod-alb/b9a4e7755f5ca7ea/23ecb2470a9d7b0b"
listener_public  = "arn:aws:elasticloadbalancing:us-east-2:766028941436:listener/app/prod-frontweb-alb/2fc0b6e04a61c114/a07358dce3843061"

lb_internal_suffix_arn = "b9a4e7755f5ca7ea"
lb_suffix_arn = "2fc0b6e04a61c114"

lb_name = "prod-frontweb-alb"

efs_id = "fs-0e982d7896523fec4" 

 user_pool_id = "us-east-2_W0AflcgFB"
 user_pool_arn = "arn:aws:cognito-idp:us-east-2:766028941436:userpool/us-east-2_W0AflcgFB"
 user_pool_domain    = "msp-cba-gov-ar" # CAMBIAR MUJER

origin_id = "msp-aws-alb.cba.gov.ar"

waf_id = "arn:aws:wafv2:us-east-1:766028941436:global/webacl/wordpress-webacl-base/662d41b0-a2d3-48cd-9a98-1eaae0d3ed28"

central_s3_bucket_arn = "arn:aws:s3:::cba-waf-webacl-log"

waf_web_acl_name = "wordpress-webacl-base"

allowed_countries = ["AR", "BO", "BR", "CL", "CO", "CR", "EC", "MX", "PA", "PY", "PE", "ES", "UY", "VE", "US"]

 uptime_robot_cloudfront = "0d27bf4f-3dfa-43d8-974d-8ea2befc3fe4/UptimeRobotIPv4List/CLOUDFRONT" #se busca desde consola haciendo aws wafv2 list-ip-sets --scope CLOUDFRONT --region us-east-1 es el ID de cloudfront <ID>/<Name>/CLOUDFRONT
 wordpress_webacl_base_arn = "arn:aws:wafv2:us-east-1:766028941436:global/webacl/wordpress-webacl-base/662d41b0-a2d3-48cd-9a98-1eaae0d3ed28" #aws wafv2 list-web-acls --scope CLOUDFRONT --region us-east-1 --> Tomar el ARN que da
 logs_cba_centralized_arn = "arn:aws:firehose:us-east-1:766028941436:deliverystream/aws-waf-logs-cba-centralized"
 wordpress_webacl_base_cloudfront = "662d41b0-a2d3-48cd-9a98-1eaae0d3ed28/wordpress-webacl-base/CLOUDFRONT" #aws wafv2 list-web-acls --scope CLOUDFRONT --region us-east-1 --> Tomar el ID que da y armarlo: <WebACL-ID>/<WebACL-Name>/CLOUDFRONT


