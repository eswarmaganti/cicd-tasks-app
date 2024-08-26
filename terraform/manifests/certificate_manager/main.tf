resource "aws_acm_certificate" "ssl_certificate" {
  domain_name       = var.domain_name
  validation_method = "DNS"
  tags = {
    Environment = "DEV"
    Name        = "Dev Env SSL Certificate"
  }
  lifecycle {
    create_before_destroy = false
  }
}


# assigning ssl certificate to route53 hosted zone
resource "aws_route53_record" "ssl_cert_validation" {
  for_each = {
    for item in aws_acm_certificate.ssl_certificate.domain_validation_options : item.domain_name => {
      name   = item.resource_record_name
      record = item.resource_record_value
      type   = item.resource_record_type
    }
  }
  zone_id = var.domain_hosted_zone_id
  name    = each.value.name
  type    = each.value.type
  records = [each.value.record]
  ttl     = 50
}
