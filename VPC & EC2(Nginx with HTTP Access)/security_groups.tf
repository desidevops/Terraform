resource "aws_security_group" "mysg" {
  vpc_id = aws_vpc.myvpc.id



# Inbound Rule for HTTP
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] 
  }

# Outbound Rule for HTTP
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"] 
  }

  tags = {
    Name = "mynginxsg"
  }
}