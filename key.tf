resource "aws_key_pair" "tf-key" {
  key_name   = "tf-key"
  public_key = file(var.pub-key)
  tags = {
    Name    = "tf-key"
    project = "terraform"
  }
}