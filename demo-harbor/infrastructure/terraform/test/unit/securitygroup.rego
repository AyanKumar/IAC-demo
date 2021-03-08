package main


deny[msg] {
  not input.resource.aws_security_group.web
  msg = "Define web security group"
}

deny[msg] {
  rule := input.resource.aws_security_group_rule[name]
  rule.type == "ingress"
  not rule.to_port == 443
  msg = "Web security group should allow ingress on app port 443"
}

deny[msg] {
  rule := input.resource.aws_security_group_rule[name]
  rule.type == "ingress"
  not rule.to_port == 80
 
  msg = "Web security group should allow ingress on port 80"
}