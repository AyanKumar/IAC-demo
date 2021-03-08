package main

region := "ap-south-1"
sshpub := "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDXQoG/yL0tf/vVLIJBglKvwHarw1HpHAXzddgApGoZmKU2Pp2jzH9C8YCeBZgh5GJpsNNPi5TOg9vcUF9u0gHSKe09PqO0vvbeNQj+XCkZd+gnbBeS78K4+GwC1bKDZJzSn+ZyLSqqI+OI59hsFj2xWK5KnqZzsLLsf5S+zj4+zaL2/08vwdwLAammShgWdqzZHWPcOH2cE48fGuEbR7hU1ezheYvUMFZsjDbCJoZPV9WLlysQcDJV1mopoVVKFsZm8E76CWTKntRm8hf+grE9t7SOEDH5TeV9mTB1V4KvpDPL2ZNaIVZPaMUwKjJyjJQGCth3JU3xJn93o27YbEXB ayan.kumar@accenture.com"


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