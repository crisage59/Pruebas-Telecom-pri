resource "aws_launch_template" "this" {
  name          = "${var.tags.Environment}-${var.tags.Site}-lt"
  image_id      = var.image_id
  instance_type = var.instance_type

  vpc_security_group_ids = [var.security_group_id]


######  #########
user_data = base64encode(<<EOF
#!/bin/bash

# Mount EFS
yum -y install amazon-efs-utils
mkdir -p "/mnt/efs"
# Modificar el fs- por el FileSystem y luego el fsap por el Access point ID
echo "${var.efs_id}" "/mnt/efs" efs _netdev,noresvport,tls,accesspoint="${var.efs_access_point_id}" 0 0 >> /etc/fstab
mount "/mnt/efs"

# Detener Apache
systemctl stop httpd
systemctl stop php-fpm

# php.ini config - linked to efs
if [ ! -d "/mnt/efs/ini" ]; then
    mkdir -p "/mnt/efs/ini"
    chown ec2-user:ec2-user "/mnt/efs/ini"
fi

if [ ! -f "/mnt/efs/ini/20-${var.app}.ini" ]; then
    touch "/mnt/efs/ini/20-${var.app}.ini"
    echo "memory_limit = 256M"       >> "/mnt/efs/ini/20-${var.app}.ini"
    echo "post_max_size = 64M"       >> "/mnt/efs/ini/20-${var.app}.ini"
    echo "upload_max_filesize = 64M" >> "/mnt/efs/ini/20-${var.app}.ini"
    echo "max_input_time = 60"       >> "/mnt/efs/ini/20-${var.app}.ini"
    echo "max_execution_time = 30"   >> "/mnt/efs/ini/20-${var.app}.ini"
fi
cp "/mnt/efs/ini/20-${var.app}.ini" /etc/php.d/20-${var.app}.ini

# Default root
if [ ! -d "/mnt/efs/conf" ]; then
    mkdir -p "/mnt/efs/conf"
    chown ec2-user:ec2-user "/mnt/efs/conf"
fi

if [ ! -f "/mnt/efs/conf/${var.app}.conf" ]; then
    touch "/mnt/efs/conf/${var.app}.conf"
    echo "ServerName 127.0.0.1:80" >> "/mnt/efs/conf/${var.app}.conf"
    echo "DocumentRoot /mnt/efs/html" >> "/mnt/efs/conf/${var.app}.conf"
    echo "<Directory /mnt/efs/html>" >> "/mnt/efs/conf/${var.app}.conf"
    echo "  Options Indexes FollowSymLinks" >> "/mnt/efs/conf/${var.app}.conf"
    echo "  AllowOverride All" >> "/mnt/efs/conf/${var.app}.conf"
    echo "  Require all granted" >> "/mnt/efs/conf/${var.app}.conf"
    echo "</Directory>" >> "/mnt/efs/conf/${var.app}.conf"
fi
ln -s "/mnt/efs/conf/${var.app}.conf" /etc/httpd/conf.d/${var.app}.conf

# make site directory
if [ ! -d "/mnt/efs/html" ]; then
    mkdir -p "/mnt/efs/html"
    chown ec2-user:ec2-user "/mnt/efs/html"
fi

# download opcache-instance.php to verify opcache status
if [ ! -f "/mnt/efs/html/opcache-instanceid.php" ]; then
    wget -P "/mnt/efs/html/" https://s3.amazonaws.com/aws-refarch/wordpress/latest/bits/opcache-instanceid.php
fi

# Iniciar Apache
systemctl start php-fpm
systemctl start httpd

# Permisos para CW Agent
chmod 755 /var/log/httpd
chmod 755 /var/log/php-fpm
chmod 644 /var/log/cloud-init-output.log

# Use cloudwatch config from SSM
/opt/aws/amazon-cloudwatch-agent/bin/amazon-cloudwatch-agent-ctl \
    -a fetch-config \
    -m ec2 \
    -c ssm:${var.ssm_parameter_id} -s 

EOF
  )

  iam_instance_profile {
    name = var.role_profile
  }
tag_specifications {
    resource_type = "instance"
    tags = {
      Name        = "${var.tags.Environment}-${var.tags.Site}-asg"
      Ambiente = var.tags.Ambiente
      Cuenta = var.tags.Cuenta
      Entidad = var.tags.Entidad
      Dependencia =  var.tags.Dependencia
      Application = "ec2"
    }
  }
  

  tag_specifications {
    resource_type = "volume"
    tags = {
      Environment = var.tags.Environment
    }
  }
}

resource "aws_autoscaling_group" "this" {
  name                = "${var.tags.Environment}-${var.tags.Site}-asg"
  desired_capacity    = var.aeg_desired_capacity
  max_size            = var.aeg_max_size
  min_size            = var.aeg_min_size
  vpc_zone_identifier = var.subnets_id
  target_group_arns   = [var.lb_target_group_internal_arn, var.lb_target_group_arn]

  launch_template {
    id      = aws_launch_template.this.id
    version = "$Default"
  }

  tag {
    key                 = "Name"
    value               = "${var.tags.Environment}-${var.tags.Site}-asg"
    propagate_at_launch = true
  }

  tag {
    key                 = "Environment"
    value               = var.tags.Environment
    propagate_at_launch = true
  }

  tag {
    key                 = "Application"
    value               = "ec2"
    propagate_at_launch = true
  }

  tag {
    key = "Entidad"
    value = var.tags.Entidad
    propagate_at_launch = true
  }

  tag {
    key = "Dependencia"
    value = var.tags.Dependencia
    propagate_at_launch = true
  }
}


resource "aws_autoscaling_policy" "cpu_utilization" {
  name                   = "cpu-utilization"
  estimated_instance_warmup = 120
  
  # Configuración de Target Tracking
  policy_type             = "TargetTrackingScaling"
  target_tracking_configuration {
    target_value          = 75.0
    predefined_metric_specification {
      predefined_metric_type = "ASGAverageCPUUtilization"
    }
  }
  # Configuración del Auto Scaling Group (ASG)
  autoscaling_group_name = aws_autoscaling_group.this.id
}

resource "aws_autoscaling_policy" "request_count_per_target" {
 name                   = "request-count-per-target"
 estimated_instance_warmup = 120
  
  #Configuración de Target Tracking
  policy_type             = "TargetTrackingScaling"
  target_tracking_configuration {
   target_value          = 250
   predefined_metric_specification {
     predefined_metric_type = "ALBRequestCountPerTarget"  
     resource_label         = "app/${var.lb_name}/${var.lb_suffix_arn}/${var.lb_target_group_suffix_arn}"   
   }
  }
  #Configuración del Auto Scaling Group (ASG)
  autoscaling_group_name = aws_autoscaling_group.this.id
}





