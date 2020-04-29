# Specify the provider and access details
provider "aws" {
  region = "${var.aws_region}"
  profile = "default"
}

resource "aws_elb" "web" {
  name = "terraform-example-elb"

  # The same availability zone as our instances
  availability_zones = aws_instance.web[*].availability_zone

  listener {
    instance_port     = 80
    instance_protocol = "http"
    lb_port           = 80
    lb_protocol       = "http"
  }

  # The instances are registered automatically
  instances = aws_instance.web[*].id
}

resource "aws_instance" "web" {
  instance_type = "m1.small"
  ami           = "ami-039a49e70ea773ffc"

  count = 1
}
