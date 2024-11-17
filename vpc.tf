
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

