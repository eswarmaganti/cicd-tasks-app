# fetching the hostedzone details
data "aws_route53_zone" "hosted_zone" {
  name         = var.domain_name
  private_zone = false
}


resource "aws_route53_record" "app_domain_record" {
  type    = "A"
  name    = var.app_domain_name
  zone_id = data.aws_route53_zone.hosted_zone.id
  alias {
    name                   = var.dev_app_lb_dns
    zone_id                = var.dev_app_lb_zone_id
    evaluate_target_health = true
  }
}
