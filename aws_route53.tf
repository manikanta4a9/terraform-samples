data "aws_route53_zone" "mp2_zone" {
  name         = var.dns_zone_fqdn
  private_zone = false
}
resource "aws_route53_record" "canonical" {
  zone_id = data.aws_route53_zone.mp2_zone.zone_id
  name    = var.canonical_domain_name
  type    = "A"
  alias {
    name                   = module.spa_cloudfront.domain_name
    zone_id                = module.spa_cloudfront.hosted_zone_id
    evaluate_target_health = false
  }
}

resource "aws_route53_record" "subject_alternative_names" {
  for_each = toset(var.subject_alternative_names)

  zone_id = data.aws_route53_zone.mp2_zone.zone_id
  name    = each.value
  type    = "A"
  alias {
    name                   = module.spa_cloudfront.domain_name
    zone_id                = module.spa_cloudfront.hosted_zone_id
    evaluate_target_health = false
  }
}

