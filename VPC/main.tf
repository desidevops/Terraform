terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
  }
  required_version = ">= 1.0"
}


provider "aws" {
  region = var.region
}


# Create a VPC
resource "aws_vpc" "myvpc" {
  cidr_block = "10.0.0.0/16"
  tags = {
Name = "my_vpc"
  }
}


resource "aws_subnet" "public-subnet" {
  vpc_id            = aws_vpc.myvpc.id
  cidr_block        = "10.0.2.0/24" 

  tags = {
    Name = "my-public-subnet"
  }
}


resource "aws_subnet" "private-subnet" {
  vpc_id            = aws_vpc.myvpc.id
  cidr_block        = "10.0.1.0/24" 

  tags = {
    Name = "my-private-subnet"
  }
}


resource "aws_internet_gateway" "myigw" {
  vpc_id = aws_vpc.myvpc.id

  tags = {
    Name = "my-igw"
  }
}


resource "aws_route_table" "myroutetable" {
  vpc_id = aws_vpc.myvpc.id
  
    route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.myigw.id
  }
}


resource "aws_route_table_association" "public-sub" {
  subnet_id      = aws_subnet.public-subnet.id
  route_table_id = aws_route_table.myroutetable.id
}

