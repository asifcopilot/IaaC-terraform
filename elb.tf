resource "aws_lb" "devops-elb" {
  name               = "devops-elb"
  load_balancer_type = "application"
  security_groups    = [aws_security_group.elb-sg.id]
  subnets            = [aws_subnet.public-sub-2.id, aws_subnet.public-sub-1.id, aws_subnet.public-sub-3.id]
  tags = {
    Name    = "${var.env}-devops-elb"
    project = "devops"
  }
}

resource "aws_lb_target_group" "devops-tg" {
  name        = "devops-tg"
  port        = 80
  protocol    = "HTTP"
  vpc_id      = aws_vpc.devops-vpc.id
  target_type = "instance"
}

resource "aws_lb_target_group_attachment" "devops-tg-attached" {
  target_group_arn = aws_lb_target_group.devops-tg.arn
  target_id        = aws_instance.webserver.id
  port             = 80
}

resource "aws_lb_listener" "elb-listner" {
  load_balancer_arn = aws_lb.devops-elb.arn
  port              = "80"
  protocol          = "HTTP"
  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.devops-tg.arn
  }

}