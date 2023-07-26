
resource "aws_instance" "webserver" {
  ami                  = "ami-024e6efaf93d85776"
  availability_zone    = "us-east-2a"
  instance_type        = "t2.micro"
  key_name             = "devops-key"
  iam_instance_profile = aws_iam_instance_profile.instance_profile.name
  # subnet_id              = aws_subnet.public-sub-1.id
  # vpc_security_group_ids = [aws_security_group.web-sg.id]
  # user_data              = file("web.sh")
  tags = {
    Name    = "web-server"
    project = "devops"
  }
}

output "publicip" {
  value = aws_instance.webserver.public_ip

}

