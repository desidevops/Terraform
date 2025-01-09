# Define the variable
variable "region" {
  description = "The AWS region to deploy the EC2 resource in"
  type        = string
  default     = "ap-south-1" 
}
