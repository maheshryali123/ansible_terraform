resource "aws_instance" "ansible" {
  ami                         = "ami-0aa7d40eeae50c9a9"
  instance_type               = "t2.micro"
  availability_zone           = "us-east-1a" 
  associate_public_ip_address = true
  key_name                    = "newkey"
  vpc_security_group_ids      = [ aws_security_group.security_ansible.id] 
  subnet_id                   = aws_subnet.subnetpublic.id
  tags = {
    Name = "instance_ansible"
  } 

  depends_on = [
    aws_vpc.vpc,
    aws_security_group.security_ansible
  ]
}

resource "null_resource" "resource" {
  triggers = {
    running_number = 1
  }
  provisioner "remote-exec" {
    connection {
        type        = "ssh"
        user        = "ubuntu"
        private_key = "~/.ssh/id_rsa"
        host = aws_instance.ansible.public_ip
    }
    inline = [
        "sudo apt update",
        "git clone https://github.com/maheshryali123/ansible_terraform.git",
        "cd ansible_terraform",
        "ansible-playbook -i hosts main.yaml"
    ]
  }

  depends_on = [
    aws_instance.ansible
  ]
}