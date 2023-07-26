resource "aws_security_group" "elb-sg" {
  name        = "elb-sg"
  description = "allow 8080 from the internet"
  vpc_id      = aws_vpc.devops-vpc.id
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    description = "allow 80 from the internet"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    Name    = "${var.env}-elb-sg"
    project = "devops"
  }
}

resource "aws_security_group" "web-sg" {
  name        = "webserver-sg"
  vpc_id      = aws_vpc.devops-vpc.id
  description = "Allow all traffic to elb group"
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port       = 80
    to_port         = 80
    protocol        = "tcp"
    description     = "Allow ll traffic to elb group"
    security_groups = [aws_security_group.elb-sg.id]
  }

  # ingress {
  #   from_port       = 80
  #   to_port         = 80
  #   protocol        = "tcp"
  #   description     = "Allow all traffic to elb group"
  #   cidr_blocks = [ "110.235.216.206/32" ]
  # }


  tags = {
    Name    = "${var.env}-elb-sg"
    project = "devops"
  }

}