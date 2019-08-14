# Resource Configuration for AWS
resource "aws_instance" "myserver" {
  ami = "ami-33f92051"
  instance_type = "t2.micro"
  key_name = "EffectiveDevOpsAWS"
  vpc_security_group_ids = ["sg-0be0161ffbdb2aa10"]

  tags = {
    Name = "helloworld"
  }
}
