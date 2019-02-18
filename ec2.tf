resource "aws_instance" "dest_instance" {
  ami                         = "ami-02e60be79e78fef21"
  instance_type               = "t2.medium"
  key_name                    = "G4"
  subnet_id                   = "subnet-2a5b0e42"
  
  root_block_device {
    volume_type           = "gp2"
    volume_size           = "30"
  }

  tags {
    Name = "dest-server"
  }
}
