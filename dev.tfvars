s3_bucket_name      = "brianteetf"
aws_profile         = "tf"
key                 = "terraform/state/dev/terraform.tfstate"
region              = "ap-northeast-1"
dynamodb_table      = "terraform-state-lock"
role_arn            = "arn:aws:iam::725448880110:role/Terraform"
dynamodb_table_name = "terraform-state-lock"
workspace           = "dev"