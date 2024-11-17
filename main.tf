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
