provider "aws" {
  profile = var.aws_profile
  region  = var.aws_region

  assume_role {
    role_arn     = var.role_arn
    session_name = "terraform-session"
  }
}

terraform {
  backend "s3" {
    bucket         = "brianteetf"
    aws_profile    = "tf"
    key            = "terraform/state/dev/terraform.tfstate"
    region         = "ap-northeast-1"
    dynamodb_table = "terraform-state-lock"
    role_arn       = "arn:aws:iam::725448880110:role/Terraform"
    encrypt        = true
  }
}

resource "aws_vpc" "vpc" {
  count = var.workspace == "dev" || var.workspace == "prod" ? 1 : 0

  cidr_block           = var.workspace == "dev" ? var.dev_vpc_cidr : var.prod_vpc_cidr
  enable_dns_support   = true
  enable_dns_hostnames = true
  tags = {
    Name = "${var.workspace}-vpc"
  }
}

resource "aws_subnet" "public_subnet" {
  count = var.workspace == "dev" || var.workspace == "prod" ? 1 : 0

  vpc_id                  = aws_vpc.vpc[count.index].id
  cidr_block              = var.workspace == "dev" ? var.dev_public_subnet_cidr : var.prod_public_subnet_cidr
  map_public_ip_on_launch = true
  availability_zone       = data.aws_availability_zones.available.names[0]
  tags = {
    Name = "${var.workspace}-public-subnet"
  }
}

resource "aws_subnet" "private_subnet" {
  count = var.workspace == "dev" || var.workspace == "prod" ? 1 : 0

  vpc_id            = aws_vpc.vpc[count.index].id
  cidr_block        = var.workspace == "dev" ? var.dev_private_subnet_cidr : var.prod_private_subnet_cidr
  availability_zone = data.aws_availability_zones.available.names[1]
  tags = {
    Name = "${var.workspace}-private-subnet"
  }
}

data "aws_availability_zones" "available" {}

variable "aws_profile" {
  description = "AWS profile to use for credentials"
}

variable "aws_region" {
  description = "AWS region"
  default     = "us-east-1"
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