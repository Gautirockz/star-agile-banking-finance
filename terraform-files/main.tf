resource "aws_instance" "test-server" {
  ami = "ami-020cba7c55df1f615"
  instance_type = "t2.micro"
  key_name = "saijenkins1"
  vpc_security_group_ids = ["sg-0bc8880998566ab15"]
  connection {
     type = "ssh"
     user = "ubuntu"
     private_key = file("./mykey.pem")
     host = self.public_ip
     }
  provisioner "remote-exec" {
     inline = ["echo 'wait to start the instance' "]
  }
  tags = {
     Name = "test-server"
     }
  provisioner "local-exec" {
     command = "echo ${aws_instance.test-server.public_ip} > inventory"
     }
  provisioner "local-exec" {
     command = "ansible-playbook /var/lib/jenkins/workspace/BankingProject/terraform-files/ansibleplaybook.yml"
     }
  }
