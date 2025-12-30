
#vpc creation block
resource "aws_vpc" "vpc02" {
    cidr_block = "10.2.0.0/16"
    region = "ap-south-1"
  tags = {
    Name = "VPC-2"
  }
}


#subnet 
resource "aws_subnet" "subnet2" {
  vpc_id = aws_vpc.vpc02.id
  cidr_block = "10.2.1.0/24"
  tags =  {
    Name = "subnet02"
  }
  
}