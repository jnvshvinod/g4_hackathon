resource "aws_instance" "dest_instance" {
  ami                         = "ami-02e60be79e78fef21"
  instance_type               = "t2.medium"
  key_name                    = "G4"
  subnet_id                   = "subnet-2a5b0e42"
  vpc_security_group_ids      = ["sg-0b46806a9a699bbd7"]
  
  root_block_device {
    volume_type           = "gp2"
    volume_size           = "30"
  }
  
  user_data = <<-EOF
                #!/bin/bash
                yum install -y aws*
                sleep 15
                yum install -y docker
                sleep 15
                sudo systemctl start docker
                EOF
  tags {
    Name = "dest-server"
  }
}
