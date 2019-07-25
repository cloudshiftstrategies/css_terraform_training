# main.tf
# Use the AWS provider and deploy resources in us-east-2 region
provider "aws" {
  region = "us-east-2"
}

# define a variable called instance_count but dont provide a default so that user will be prompted to provide
variable "instance_count" {
  default = 1
}
# define a variable with my name set as the default (can be over-ridden at run-time)
variable "my_name" {
  default = "YOUR_NAME"
}

# create a number of EC2 instances
resource "aws_instance" "my_instance" {
  # if var.instance count is > 2 ? then create 0 instances : else create the number specified in var.instance_count
  count = var.instance_count > 2 ? 0 : var.instance_count
  # The amazon machine image number (only valid in us-east-2)
  ami = "ami-0d8f6eb4f641ef691"
  # The instance size
  instance_type = "t2.micro"
  # Specify this block of tags on the resource
  tags = {
    # set the tag key: "Name"  = "Brian Peterson-1". Adding 1 to count.index because it starts at zero
    Name = "${var.my_name}-${count.index + 1}"
  }
}

# Create an output with instance name and IP address
output "instance_ids" {
  # create a list of private_ip addresses of each instance
  value = aws_instance.my_instance[*].private_ip
}
