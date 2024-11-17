variable "aws_profile" {
  description = "AWS profile to use for credentials"
}

variable "aws_region" {
  description = "AWS region"
  default     = "ap-northeast-1"
}

variable "workspace" {
}

variable "dev_vpc_cidr" {
  default = "10.0.0.0/16"
}

variable "dev_public_subnet_cidr" {
  default = "10.0.1.0/24"
}

variable "dev_private_subnet_cidr" {
  default = "10.0.2.0/24"
}

variable "prod_vpc_cidr" {
  default = "10.1.0.0/16"
}

variable "prod_public_subnet_cidr" {
  default = "10.1.1.0/24"
}

variable "prod_private_subnet_cidr" {
  default = "10.1.2.0/24"
}

variable "s3_bucket_name" {
  description = "Name of the S3 bucket to store Terraform state"
}

variable "dynamodb_table_name" {
  description = "Name of the DynamoDB table for state locking"
}

variable "role_arn" {
  description = "The ARN of the role to assume"
}