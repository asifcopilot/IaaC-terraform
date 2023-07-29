variable "ami" {}

resource "aws_instance" "webserver" {
  ami                    = var.ami
  availability_zone      = var.az[0]
  instance_type          = "t2.micro"
  key_name               = "devops-key"
  subnet_id              = aws_subnet.public-sub-1.id
  iam_instance_profile   = aws_iam_instance_profile.instance_profile.name
  vpc_security_group_ids = [aws_security_group.web-sg.id]
  user_data              = file("web.sh")
  tags = {
    Name    = "${var.env}-web-server"
    project = "devops"
  }
}

output "publicip" {
  value = aws_instance.webserver.public_ip

}