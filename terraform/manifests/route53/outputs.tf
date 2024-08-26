output "domain_hosted_zone_id" {
  value = data.aws_route53_zone.hosted_zone.id
}
