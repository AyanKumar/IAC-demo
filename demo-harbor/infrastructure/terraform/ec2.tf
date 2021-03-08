data "aws_ami" "image_harbor" {
  most_recent = true
  filter {
    name   = "image-id"
    values = ["${var.image_harbor}"]
  }

  owners = ["self"]
}

resource "aws_key_pair" "keypair" {
  key_name_prefix = "demo"
  public_key      = var.sshkey_metadata
}

resource "aws_instance" "harbor" {

  instance_type = "t2.xlarge"
  ami           = data.aws_ami.image_harbor.id

  tags = {
    Name = "harbor-server"
  }

  key_name                    = aws_key_pair.keypair.id
  subnet_id                   = aws_subnet.public.id
  disable_api_termination     = false
  associate_public_ip_address = true


  vpc_security_group_ids = ["${aws_security_group.web.id}"]



  root_block_device {
    volume_size           = "50"
    delete_on_termination = true
    volume_type           = "gp2"
    encrypted             = true
  }
  
  provisioner "remote-exec" {
    inline = [
      "chmod +x /home/centos/harbor_builder.sh",
      "/home/centos/harbor_builder.sh",
    ]
  }
}