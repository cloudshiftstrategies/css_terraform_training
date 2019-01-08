# main.tf
# use the aws provider
provider "aws" {
  region = "us-east-2"
}

# Get the latest ubuntu 18.04 image
data "aws_ami" "my_ami" {
  filter {
    name = "name"
    values = [
      "ubuntu/images/hvm-ssd/ubuntu-bionic-18.04-amd64-server-*"]
  }
  most_recent = true
}

# Deploy an instance named after me
resource "aws_instance" "my_instance" {
  ami = "${data.aws_ami.my_ami.id}"
  instance_type = "t2.micro"
  tags = {
    Name = "${var.my_name}"
  }
}

# A variable with my name
variable "my_name" {
  default = "brian peterson"
}

# Return the aws instance id
output "instance_id" {
  value = "${aws_instance.my_instance.id}"
}