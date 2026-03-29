
# old cloudfront default certificate commented out
# viewer_certificate {
#   cloudfront_default_certificate = true
# }

# create ACM certificate for CloudFront with automatic DNS validation
resource "aws_acm_certificate" "site_cert" {
  provider          = aws.us_east_1
  domain_name       = "faizal-tf-cf-s3-bucket.sctp-sandbox.com"
  validation_method = "DNS"
}

# validate the ACM certificate after DNS record creation
resource "aws_acm_certificate_validation" "site_cert_validation" {
  provider                = aws.us_east_1
  certificate_arn         = aws_acm_certificate.site_cert.arn
  validation_record_fqdns = [for record in aws_route53_record.cert_validation : record.fqdn]
}
