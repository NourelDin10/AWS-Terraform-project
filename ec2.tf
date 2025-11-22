data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd-gp3/ubuntu-noble-24.04-amd64-server-*"]
  }

  owners = ["099720109477"]
}

# Read the public key from file
locals {
  public_key_content = file(var.public_key_path)
}

# Create AWS Key Pair
resource "aws_key_pair" "ec2_key" {
  key_name   = "task-terraform.pem"
  public_key = local.public_key_content
  tags = {
    Name = "task-terraform-keypair"
  }
}





resource "aws_instance" "frontend" {
  ami                         = data.aws_ami.ubuntu.id
  instance_type               = "t2.micro"
  key_name                    = aws_key_pair.ec2_key.key_name
  security_groups             = [aws_security_group.http-ssh.id]
  subnet_id                   = aws_subnet.Frontend-Public.id
  associate_public_ip_address = true

  root_block_device {
    volume_size = 8
    volume_type = "gp3"
    encrypted   = true
  }


  availability_zone = var.availability_zone

  user_data = <<-EOF
              #!/bin/bash
              apt-get update
              apt-get upgrade -y
              EOF
}
resource "aws_instance" "backend" {
  ami                         = data.aws_ami.ubuntu.id
  instance_type               = "t2.micro"
  key_name                    = aws_key_pair.ec2_key.key_name
  security_groups             = [aws_security_group.http-ssh.id]
  subnet_id                   = aws_subnet.Backend-public.id
  associate_public_ip_address = true

  root_block_device {
    volume_size = 8
    volume_type = "gp3"
    encrypted   = true
  }

  availability_zone = var.availability_zone
  user_data         = <<-EOF
              #!/bin/bash
              apt-get update
              apt-get upgrade -y
              EOF
}



