
# create DNS validation record
resource "aws_route53_record" "cert_validation" {
  for_each = {
    for dvo in aws_acm_certificate.site_cert.domain_validation_options :
    dvo.domain_name => dvo
  }

  zone_id = data.aws_route53_zone.site.zone_id
  name    = each.value.resource_record_name
  type    = each.value.resource_record_type
  records = [each.value.resource_record_value]
  ttl     = 60
}

# create route53 alias record pointing to cloudfront
resource "aws_route53_record" "site_alias" {
  zone_id = data.aws_route53_zone.site.zone_id
  name    = "faizal-tf-cf-s3-bucket.sctp-sandbox.com"
  type    = "A"

  alias {
    name                   = aws_cloudfront_distribution.site.domain_name
    zone_id                = aws_cloudfront_distribution.site.hosted_zone_id
    evaluate_target_health = false
  }
}
