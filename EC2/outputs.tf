
output "instance_id" {
  value = aws_instance.my_ec2_instance.id
}

output "public_ip" {
  value = aws_instance.my_ec2_instance.public_ip
}

output "public_dns" {
  value = aws_instance.my_ec2_instance.public_dns
}