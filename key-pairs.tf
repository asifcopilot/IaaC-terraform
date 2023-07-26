resource "aws_key_pair" "devops-key" {
  key_name   = "devops-key"
  public_key = file("devops-key.pub")
  tags = {
    Name    = "${var.env}devops-key"
    project = "devops"
  }
}