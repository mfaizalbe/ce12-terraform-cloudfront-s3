
locals {
  # use local variable
  domain = "sctp-sandbox.com"
  fqdn = "${var.subdomain}.sctp-sandbox.com"
}
