
# application load balencer for frontend react application
resource "aws_lb" "dev_app_lb" {
  name                       = "dev-app-lb"
  internal                   = false
  load_balancer_type         = "application"
  security_groups            = [var.dev_app_lb_sg_id]
  enable_deletion_protection = false
  subnets                    = var.public_subnet_ids
}

# loadbalencer target group for autoscaling group
resource "aws_lb_target_group" "dev_app_lb_tg" {
  name     = "dev-app-lb-tg"
  port     = 3000
  vpc_id   = var.vpc_id
  protocol = "HTTP"
  health_check {
    path                = "/"
    interval            = 30
    port                = 3000
    healthy_threshold   = 2
    unhealthy_threshold = 5
    timeout             = 25
    matcher             = "200,201"

  }
}


resource "aws_lb_listener" "frontend_app_listener" {
  load_balancer_arn = aws_lb.dev_app_lb.arn
  port              = 80
  protocol          = "HTTP"
  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.dev_app_lb_tg.arn
  }
}

resource "aws_lb_listener" "app_lb_https_listener" {
  load_balancer_arn = aws_lb.dev_app_lb.arn
  port              = 443
  protocol          = "HTTPS"
  ssl_policy        = "ELBSecurityPolicy-FS-1-2-Res-2019-08"
  certificate_arn   = var.ssl_certificate_arn
  default_action {
    target_group_arn = aws_lb_target_group.dev_app_lb_tg.arn
    type             = "forward"
  }
}
