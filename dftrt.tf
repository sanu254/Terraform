
resource "aws_default_route_table" "dft-rt01" {
    default_route_table_id = aws_vpc.vpc01.default_route_table_id
    route  {
      cidr_block = "0.0.0.0/0"
        gateway_id =aws_internet_gateway.IGW-01.id
  
    }

route {
  cidr_block = "10.2.0.0/16"
  vpc_peering_connection_id = aws_vpc_peering_connection.peer1-peer2.id
}
    tags = {
      Name = "dftrt-01"
    }
}

resource "aws_default_route_table" "dft-rt02" {
   default_route_table_id = aws_vpc.vpc02.default_route_table_id

     route  { 
    cidr_block = "0.0.0.0/0"
         gateway_id =aws_internet_gateway.IGW-02.id
  }

route {
  cidr_block = "10.1.0.0/16"
  vpc_peering_connection_id = aws_vpc_peering_connection.peer1-peer2.id

}
  tags = {
    Name = "dftrt-02"
  }
}
