locals {
  domain_validation_options = var.create_tls_cert == true ? aws_acm_certificate.main[0].domain_validation_options : []
}

resource "aws_acm_certificate" "main" {
  count                     = var.create_tls_cert == true ? 1 : 0
  domain_name               = var.canonical_domain_name
  subject_alternative_names = var.subject_alternative_names
  validation_method         = "DNS"
  provider                  = aws.us_east_1

  tags = {
    Environment = var.environment
    Name        = var.name
  }

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_route53_record" "tls_cert_validation" {
  for_each = {
    for dvo in local.domain_validation_options : dvo.domain_name => {
      name   = dvo.resource_record_name
      record = dvo.resource_record_value
      type   = dvo.resource_record_type
    }
  }

  allow_overwrite = true
  name            = each.value.name
  records = [
  each.value.record]
  ttl     = 60
  type    = each.value.type
  zone_id = data.aws_route53_zone.mp2_zone.zone_id
}

