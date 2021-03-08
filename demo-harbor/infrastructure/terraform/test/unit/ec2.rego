package main

deny[msg]{
  not input.resource.aws_key_pair
  msg= "Provide a key pair"
}

deny[msg]{
   
   not input.resource.aws_instance
   msg= "Provide a instance."
}

deny[msg]{
   not input.data.aws_ami
   msg =" Provide aws data source"

}

