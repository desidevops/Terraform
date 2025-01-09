# Create a EC2 in VPC 
resource "aws_instance" "nginxserver" {
  ami           = "ami-0dee22c13ea7a9a67"  
  instance_type = "t2.micro"     
  subnet_id = aws_subnet.public-subnet.id
  vpc_security_group_ids = [ aws_security_group.mysg.id ]
  associate_public_ip_address = true
  
  user_data = <<-EOF
              #!/bin/bash
              sudo apt update
              sudo apt install -y nginx
              sudo systemctl start nginx
              EOF


  tags = {
    Name = "nginxserver"
  }
}
