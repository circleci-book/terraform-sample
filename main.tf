# Specify the provider and access details
provider "aws" {
  region  = "ap-northeast-1"
  profile = "default"
}

terraform {
  backend "s3" {
    key            = "terraform.tfstate"
    bucket         = "circleci-book-terraform-sample-yuta"
    region         = "ap-northeast-1"
    dynamodb_table = "terraform-state-lock-dynamo"
  }
}

resource "aws_dynamodb_table" "dynamodb-terraform-state-lock" {
  name           = "terraform-state-lock-dynamo"
  hash_key       = "LockID"
  read_capacity  = 20
  write_capacity = 20

  attribute {
    name = "LockID"
    type = "S"
  }

  tags = {
    Name = "DynamoDB State Lock Table"
  }
}

resource "aws_instance" "web" {
  instance_type = "m5.large"
  # Ubuntu 19.04 LTS AMI
  ami   = "ami-0e039c7d64008bd84"
  count = 1
}
