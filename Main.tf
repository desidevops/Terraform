provider "aws" {
  region = var.region
}

resource "aws_instance" "my_ec2_instance" {
  ami           = "ami-0dee22c13ea7a9a67"  
  instance_type = "t2.micro"               

  tags = {
    Name = "MyEC2InstancebyTerraform"
  }
}
