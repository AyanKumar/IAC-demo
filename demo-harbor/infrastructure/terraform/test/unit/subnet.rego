package main

deny[msg] {
  not input.resource.aws_subnet.public
  msg = "Define public subnet resource"
}



deny[msg] {
  not input.resource.aws_subnet.public.map_public_ip_on_launch
  msg = "Public Subnet CIDR Block is not public"
}

deny[msg] {
  not input.resource.aws_subnet.public.tags.Name
  msg = "Public subnet missing tag `Name`"
}

deny[msg] {
  not contains(input.resource.aws_subnet.public.availability_zone, "data.aws_availability_zones.available")
  msg = "Use data resources to interpolate availability zone"
}


