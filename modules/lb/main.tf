

resource "aws_lb_target_group" "this" {
  name     = "${var.tags.Environment}-${var.tags.Site}-lb-tg"
  port     = 80
  protocol = "HTTP"
  vpc_id   = var.vpc_id

  health_check {
    path                = "/robots.txt"
    interval            = 30
    timeout             = 5
    healthy_threshold   = 2
    unhealthy_threshold = 2
  }

}

resource "aws_autoscaling_attachment" "this" {
  autoscaling_group_name = var.autoscaling_group_id
  
  lb_target_group_arn    = aws_lb_target_group.this.arn
}

resource "aws_lb_target_group" "this-internal" {
  name     = "${var.tags.Environment}-${var.tags.Site}-int-tg"
  port     = 80
  protocol = "HTTP"
  vpc_id   = var.vpc_id

  health_check {
    path                = "/robots.txt"
    interval            = 30
    timeout             = 5
    healthy_threshold   = 2
    unhealthy_threshold = 2
  }
}

resource "aws_autoscaling_attachment" "this-internal" {
  autoscaling_group_name = var.autoscaling_group_id
  lb_target_group_arn    = aws_lb_target_group.this-internal.arn
}


resource "aws_lb_listener_rule" "this-internal" {
  listener_arn = var.listener_private
  priority     = 290

  action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.this-internal.arn
  }

  condition {
    host_header {
      values = ["${var.tags.Site}.cba.gov.ar"]
    }
  }

  condition {
    path_pattern {
      values = ["*"]
    }
  }

  tags = var.tags
}


resource "aws_lb_listener_rule" "this" {
  listener_arn = var.listener_public
  priority     = 290

  action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.this.arn
  }

  condition {
    host_header {
      values = ["${var.tags.Site}.cba.gov.ar"]
    }
  }

  condition {
    path_pattern {
      values = ["*"]
    }
  }


  tags = var.tags
}


resource "aws_lb_listener_rule" "this_cognito" {
  listener_arn = var.listener_public

  condition {
    host_header {
      values = ["${var.tags.Site}.cba.gov.ar"]
    }
  }

  condition {
    path_pattern {
      values = ["/wp-login.php", "/wp-admin", "/wp-admin/","/wp-admin/*"]
    }
  }

  action {
    type = "authenticate-cognito"
    
    authenticate_cognito {
      user_pool_arn       = var.user_pool_arn
      user_pool_client_id = var.user_pool_client_id
      user_pool_domain    = var.user_pool_domain
      authentication_request_extra_params = {
        display = "page"
        prompt  = "login"
      }
      session_timeout = "3600"
    }
  }

  action {
    type = "forward"
    forward {
      target_group {
        arn    = aws_lb_target_group.this.arn
        weight = 1
      }
      stickiness{
        duration = 3600
      }
    }
  }

  priority = 199

}

resource "aws_lb_listener_certificate" "internal" {
  listener_arn    = var.listener_private
  certificate_arn = var.acm_certificate_arn

}
