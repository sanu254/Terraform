

#vpc creation block
resource "aws_vpc" "vpc01" {
    cidr_block = "10.1.0.0/16"
  tags = {
    Name = "VPC-1"
  }
}

