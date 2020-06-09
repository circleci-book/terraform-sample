provider "aws" {
  region  = "ap-northeast-1"
  profile = "default"
}

terraform {
  backend "s3" {
    key            = "terraform.tfstate"
    bucket         = "circleci-book-terraform-sample"
    region         = "ap-northeast-1"
    dynamodb_table = "terraform-state-lock"
  }
}

resource "aws_dynamodb_table" "dynamodb-terraform-state-lock" {
  name = "terraform-state-lock-dynamo"
  hash_key = "LockID"
  read_capacity = 20
  write_capacity = 20

  attribute {
    name = "LockID"
    type = "S"
  }

  tags = {
    Name = "DynamoDB Terraform State Lock Table"
  }
}

#resource "aws_elb" "web" {
#  name = "terraform-example-elb"
#
#  # The same availability zone as our instances
#  availability_zones = aws_instance.web[*].availability_zone
#
#  listener {
#    instance_port     = 80
#    instance_protocol = "http"
#    lb_port           = 80
#    lb_protocol       = "http"
#  }
#
#  # The instances are registered automatically
#  instances = aws_instance.web[*].id
#}

resource "aws_instance" "web" {
  instance_type = "m1.small"
  # Ubuntu 19.04 LTS AMI
  ami   = "ami-07547ba969550e510"
  count = 2
}
