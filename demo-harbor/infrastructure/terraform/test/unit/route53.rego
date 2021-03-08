package main

deny[msg]{
  not input.resource.aws_route53_record
  msg="please add entry in route 53"
}