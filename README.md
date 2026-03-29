# ce12-terraform-cloudfront-s3
Terraform to host a secure static site using CloudFront and S3.

This repository contains Terraform code to deploy a **private S3 bucket** fronted by **CloudFront**, with **HTTPS using ACM**, **custom domain alias using Route53**, and an **optional WAF Web ACL** for security.

---

## Features

- **Private S3 bucket** to store static website files.
- **CloudFront distribution** for CDN with low-latency delivery.
- **HTTPS using ACM** certificate automatically validated via DNS.
- **Custom domain alias** using Route53.
- **Optional WAF** for protecting the CloudFront distribution.
- Automatic dependency handling with Terraform.

---

## Prerequisites

- Terraform >= 1.5.0
- AWS account with permissions for:
  - S3, CloudFront, ACM, Route53, WAFv2
- Domain managed in **Route53** (for automatic DNS validation).

---

## File Structure

| File             | Purpose |
|------------------|---------|
| `provider.tf`    | Configures AWS providers for default region and `us-east-1` (required for ACM/WAF). |
| `s3.tf`          | Creates private S3 bucket and bucket policy for CloudFront access. |
| `cloudfront.tf`  | Configures CloudFront distribution with origin access control. |
| `acm.tf`         | Requests ACM certificate and validates via DNS. |
| `route53.tf`     | Creates Route53 alias record pointing to CloudFront. |
| `waf.tf`         | Optional WAF Web ACL and association with CloudFront. |

---

## Usage

1. **Clone the repo**
   ```bash
   git clone <repo-url> ce12-terraform-cloudfront-s3
   cd ce12-terraform-cloudfront-s3
   ```

2. **Initialize Terraform**
    ```bash
    terraform init
    ```

3. **Plan the deployment**
    ```bash
    terraform plan
    ```

4. **Apply the deployment**
    ```bash
    terraform apply
    ```

### Terraform will create:

- Private S3 bucket
- CloudFront distribution with HTTPS
- ACM certificate validated via Route53
- Route53 alias record
- Optional WAF Web ACL

5. **Upload your static website**
 aws s3 sync . s3://faizal-tf-cf-s3-bucket  --exclude "*.MD" --exclude ".git*"

 6. **Access your website**
 - Visit https://faizal-tf-cf-s3-bucket.sctp-sandbox.com after CloudFront propagation (~15–20 mins).

---

## Learnings / Key Takeaways

While building this Terraform project, I learned several important concepts and best practices for AWS infrastructure automation:

1. S3 + CloudFront Integration
- How to create a private S3 bucket and securely serve its content using CloudFront.
- Using Origin Access Control (OAC) to allow CloudFront to access S3 without making the bucket public.
2. ACM Certificates
- Certificates for CloudFront must be in us-east-1.
- Learned how to automate DNS validation using Route53, so HTTPS setup is fully automated.
3. Custom Domains with Route53
- How to create alias records pointing to CloudFront distributions.
- Understanding of FQDN, zone IDs, and routing traffic securely.
4. Terraform Multi-Provider Setup
- Using aliased providers to manage resources in multiple regions (ap-southeast-1 for S3/CloudFront, us-east-1 for ACM/WAF).
- Handling resource dependencies across .tf files effectively.
5. Optional WAF Security
- Learned about WAFv2 Web ACLs and associating them with CloudFront.
- Importance of regional requirements for WAF (must also be in us-east-1).
6. Terraform Best Practices
- Organizing resources into separate .tf files by responsibility improves readability and maintainability.
- Using comments and clear naming helps anyone understand the infrastructure quickly.
- Learned about automatic dependency resolution, so resources like ACM certificate validation and CloudFront alias work in order.
7. End-to-End HTTPS Setup
- Combining CloudFront, ACM, and Route53 ensures secure, globally distributed static websites.
- Optional WAF adds layer 7 security, giving control over traffic to protect against attacks.

### This project strengthened my understanding of AWS infrastructure automation, Terraform multi-region setup, and security best practices for static websites.

---

## Cleanup

To destroy all resources:
    ```bash
    terraform destroy
    ```