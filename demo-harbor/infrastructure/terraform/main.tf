
terraform {
  required_version = "~> 0.12"
}

provider "aws" {
  region = var.region
  #version = "~> 2.59"
}

provider "local" {

}

locals {

  external_dns = "${var.dns_prefix}.${var.domainname}"
  name         = var.tagname
}

output "DNS" {
  value = aws_route53_record.harbor-external.name

}