# configure aws provider
# this tells terraform which region to deploy resources
provider "aws" {
  region = "ap-southeast-1"
}

# aliased provider for ACM (us-east-1)
provider "aws" {
  alias  = "us_east_1"
  region = "us-east-1"
}
