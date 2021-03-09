
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

  external_dns = "altran.${var.domainname}"
  name = "harbor"
}