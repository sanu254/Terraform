
resource "aws_vpc_peering_connection" "peer1-peer2"{

peer_vpc_id = aws_vpc.vpc02.id
 vpc_id = aws_vpc.vpc01.id
 auto_accept = true

 tags = {
   Name = "peering between peer1 and 2"

 }

}

