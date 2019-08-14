# Resource Configuration for AWS
resource "aws_instance" "myserver" {
  ami = "ami-33f92051"
  instance_type = "t2.micro"
  key_name = "EffectiveDevOpsAWS"
  vpc_security_group_ids = ["sg-0be0161ffbdb2aa10"]

  tags = {
    Name = "helloworld"
  }

# Provisioner for applying Ansible playbook in Pull mode
  provisioner "remote-exec" {
    connection {
      type = "ssh"
      host = self.public_ip
      user = "ec2-user"
      private_key = "${file("/home/stan/.ssh/EffectiveDevOpsAWS.pem")}"
    }
    inline = [
      "sudo yum install --enablerepo=epel -y ansible git",
      "wget https://raw.githubusercontent.com/stanosaka/ansible/master/localhost",
      "ansible-pull -U https://github.com/stanosaka/ansible helloworld.yml -i localhost",
    ]
  }
 
}

# IP address of newly created EC2 instance
output "myserver" {
 value = "${aws_instance.myserver.public_ip}"
}

