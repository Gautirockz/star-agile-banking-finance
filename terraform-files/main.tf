variable "private_key_path" {
  description = "Path to PEM file for SSH connection"
}

resource "aws_instance" "test-server" {
  ami                    = "ami-052064a798f08f0d3"
  instance_type          = "t2.micro"
  key_name               = "saijenkins1"
  vpc_security_group_ids = ["sg-0040ea524604db821"]

  connection {
    type        = "ssh"
    user        = "ubuntu"
    private_key = file(var.private_key_path)
    host        = self.public_ip
    timeout     = "5m"
  }

  provisioner "remote-exec" {
    inline = [
      "echo '⏳ Waiting for instance to be ready for SSH...'",
      "sleep 60",
      "sudo apt-get update -y",
      "sudo apt-get install -y nginx",
      "sudo systemctl start nginx",
      "sudo systemctl enable nginx",
      "echo '✅ Nginx installed successfully!'"
    ]
  }

  tags = {
    Name = "test-server"
  }

  provisioner "local-exec" {
    command = "echo ${self.public_ip} > inventory"
  }
}
