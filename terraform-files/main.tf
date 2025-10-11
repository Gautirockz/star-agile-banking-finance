variable "private_key_path" {
  description = "Path to the PEM file for SSH connection"
}

resource "aws_instance" "test-server" {
  ami                    = "ami-052064a798f08f0d3"
  instance_type          = "t2.micro"
  key_name               = "saijenkins1"
  vpc_security_group_ids = ["sg-0040ea524604db821"]

  # SSH Connection
  connection {
    type        = "ssh"
    user        = "ubuntu"
    private_key = file(var.private_key_path)
    host        = self.public_ip
  }

  # Remote-exec provisioner (runs inside EC2)
  provisioner "remote-exec" {
    inline = [
      "echo 'Waiting for instance to start...'",
      "sudo apt update -y",
      "sudo apt install -y nginx",
      "sudo systemctl start nginx",
      "sudo systemctl enable nginx",
      "echo 'Nginx installed successfully!'"
    ]
  }

  # Tag for identification
  tags = {
    Name = "test-server"
  }

  # Local-exec provisioner (runs on Jenkins)
  provisioner "local-exec" {
    command = "echo ${self.public_ip} > inventory"
  }

  # Run Ansible playbook after instance is ready
  provisioner "local-exec" {
    command = "ansible-playbook -i inventory /var/lib/jenkins/workspace/BankingProject/terraform-files/ansibleplaybook.yml"
  }
}
