resource "aws_key_pair" "devops-key" {
  key_name   = "devops-key"
  public_key = file("devops-key.pub")
  tags = {
    Name    = "devops-key"
    project = "devops"
  }
}