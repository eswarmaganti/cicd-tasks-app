output "dev_app_lb_tg" {
  value = aws_lb_target_group.dev_app_lb_tg.id
}

output "dev_app_lb_dns" {
  value = aws_lb.dev_app_lb.dns_name
}

output "dev_app_lb_zone_id" {
  value = aws_lb.dev_app_lb.zone_id
}