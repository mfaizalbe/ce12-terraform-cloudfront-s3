
# get the hosted zone
data "aws_route53_zone" "site" {
  name         = "sctp-sandbox.com"
  private_zone = false
}
