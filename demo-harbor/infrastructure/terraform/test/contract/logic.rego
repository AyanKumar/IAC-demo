package main

region := "ap-south-1"
name := "harbor"


contains_variables(variables) {
  variables.vpc_cidr.value = "10.128.0.0/16"
  variables.region.value = region
  variables.image_harbor.value= "ami-04a9d4ba46f94056e"
  variables.domainname.value = "demo.iac.harbor.com"
  variables.hostedzone_id.value = "Z03001001Z8W2DJAO5DM8"

}

deny[msg] {
  not contains_variables(input.variables)
  msg = "Variables are not populated with expected values"
}

deny[msg] {
  subnets := [r | r := input.planned_values.root_module.resources[_]; r.address == "aws_subnet.public"]
  subnets[0].values.cidr_block != "10.128.0.0/19"
  msg = sprintf("Public subnet has wrong CIDR: `%v`", [subnets])
}

deny[msg] {
  untagged := [r | r := input.planned_values.root_module.resources[_]; r.values.tags.Name != name ]
  count(untagged) != 0
  msg = sprintf("Resources missing Name tag: `%v`", untagged)
}