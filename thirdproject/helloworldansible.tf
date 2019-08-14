# Resource Configuration for AWS
resource "aws_instance" "myserver" {
  ami = "ami-33f92051"
  instance_type = "t2.micro"
  key_name = "EffectiveDevOpsAWS"
  vpc_security_group_ids = ["sg-0be0161ffbdb2aa10"]

  tags = {
    Name = "helloworld"
  }

# Provisioner for applying Ansible playbook
  provisioner "remote-exec" {
    connection {
      type = "ssh"
      host = self.public_ip
      user = "ec2-user"
      private_key = "${file("/home/stan/.ssh/EffectiveDevOpsAWS.pem")}"
    }
  }
  
  provisioner "local-exec" {
    command = "echo ${self.public_ip} > ./myinventory"
  }

  provisioner "local-exec" {
    command = "ansible-playbook -i myinventory --private-key=/home/stan/.ssh/EffectiveDevOpsAWS.pem helloworld.yml"
  }  
}

# IP address of newly created EC2 instance
output "myserver" {
 value = "${aws_instance.myserver.public_ip}"
}

