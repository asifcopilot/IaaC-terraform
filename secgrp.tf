resource "aws_security_group" "tf-sg" {
  name        = "terraform-sg"
  description = "Allow 80 port to web on tf-sg"
  vpc_id      = aws_vpc.vpc.id
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    description = "allow 80 from web"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    description = "allow 22 from web"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    Name    = "tf-sg"
    project = "devops-terraform"
  }

  depends_on = [
    aws_vpc.vpc
  ]

}
