
# optional waf to protect CloudFront from malicious requests
# this is a web access control list (ACL) for layer 7 security
resource "aws_wafv2_web_acl" "site_waf" {
  provider = aws.us_east_1

  # name of the WAF ACL
  name  = "site-waf"
  
  # scope defines where the WAF applies
  # CLOUDFRONT = protects a CloudFront distribution globally
  scope = "CLOUDFRONT"
 
  # default action for requests not matching any rules
  # here, we allow all requests by default
  default_action { 
    allow {} 
  }
 
  # visibility configuration for monitoring in CloudWatch
  visibility_config {
    # enable sending metrics to CloudWatch
    cloudwatch_metrics_enabled = true
    
    # the name of the metric in CloudWatch
    metric_name = "siteWAF"
    
    # enable sampling of requests for logging
    sampled_requests_enabled   = true
  }
}