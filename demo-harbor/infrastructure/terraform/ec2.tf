data "aws_ami" "image_harbor" {
  most_recent = true
  filter {
    name   = "image-id"
    values = [var.image_harbor]
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
    Name = local.name
  }

  key_name                    = aws_key_pair.keypair.id
  subnet_id                   = aws_subnet.public.id
  disable_api_termination     = false
  associate_public_ip_address = true


  vpc_security_group_ids = [aws_security_group.web.id]



  root_block_device {
    volume_size           = "50"
    delete_on_termination = true
    volume_type           = "gp2"
    encrypted             = true
  }
  provisioner "file" {
    source      = "harbor_builder.sh"
    destination = "/home/centos/harbor_builder.sh"
  }
  provisioner "file" {
    source      = "harbor.yml"
    destination = "/home/centos/harbor.yml"
  }
  provisioner "remote-exec" {
    inline = [
      "sudo ls /home/centos/",
      "chmod +x /home/centos/harbor_builder.sh",
      "/home/centos/harbor_builder.sh ${aws_instance.harbor.public_ip}"


    ]
  }

  connection {
    type        = "ssh"
    user        = "centos"
    password    = ""
    private_key = file("~/.ssh/id_rsa")
    host        = aws_instance.harbor.public_ip
  }
}