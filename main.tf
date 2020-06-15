# Specify the provider and access details
provider "aws" {
  region  = "ap-northeast-1"
  profile = "default"
}

terraform {
  backend "s3" {
    key            = "terraform.tfstate"
    bucket         = "circleci-book-terraform-sample"
    region         = "ap-northeast-1"
  }
}

resource "aws_instance" "web" {
  instance_type = "m1.small"
  # Ubuntu 19.04 LTS AMI
  ami   = "ami-07547ba969550e510"
  count = 1
}
