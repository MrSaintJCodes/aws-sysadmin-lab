# keypair.tf
resource "aws_key_pair" "main" {
  key_name   = "aws-key"
  public_key = file("~/.ssh/aws_key.pub")
}
