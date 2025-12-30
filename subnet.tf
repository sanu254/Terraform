
#subnet creation block
resource "aws_subnet" "subnet"{
   vpc_id = aws_vpc.vpc01.id
    cidr_block = "10.1.1.0/24"
  tags = {
    Name = "subnet01"
  }
}
