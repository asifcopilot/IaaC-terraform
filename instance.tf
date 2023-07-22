resource "aws_instance" "web01" {
  ami                    = var.AMIS[var.REGION]
  availability_zone      = var.az1
  instance_type          = "t2.micro"
  key_name               = aws_key_pair.tf-key.key_name
  subnet_id              = aws_subnet.pubsub1.id
  vpc_security_group_ids = [aws_security_group.tf-sg.id]
  tags = {
    Name = "web01"
    project = "terraform"
  }
}

resource "aws_ebs_volume" "extra_volume" {
  availability_zone = var.az1
  size              = "3"
  tags = {
    Name    = "extra_volume"
    project = "terraform"
  }
}

resource "aws_volume_attachment" "volume-add" {
  device_name = "/dev/xvdh"
  volume_id   = aws_ebs_volume.extra_volume.id
  instance_id = aws_instance.web01.id
}

output "Public-ip" {
  value = aws_instance.web01.public_ip
}

output "private-ip" {
  value = aws_instance.web01.private_ip
}

