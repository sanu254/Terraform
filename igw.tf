resource "aws_internet_gateway" "IGW-01" {
    vpc_id = aws_vpc.vpc01.id

     tags = {
       Name = "igw01"
     }
}

resource  "aws_internet_gateway""IGW-02"{
   vpc_id = aws_vpc.vpc02.id
   
   tags = {
     Name = "igw02"
   }
}
