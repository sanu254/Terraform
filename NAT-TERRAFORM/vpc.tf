#vpc block
resource "aws_vpc" "vpc" {
    cidr_block = "10.1.0.0/16"

    tags = {
      Name="VPC"
    }
  
}
#public subnet block
resource "aws_subnet" "public-subnet" {
    vpc_id = aws_vpc.vpc.id
    cidr_block = "10.1.1.0/24"
    map_public_ip_on_launch = "true"
    tags = {
      Name="PUBLIC-SUBNET"
    }
}
#private subnet block
resource "aws_subnet" "private-subnet" {
    vpc_id = aws_vpc.vpc.id
    cidr_block = "10.1.2.0/24"
    map_public_ip_on_launch = "true"
    tags = {
      Name="PRIVATE-SUBNET"
    }
}
#igw block
resource "aws_internet_gateway" "igw" {
    vpc_id = aws_vpc.vpc.id
    tags = {
      Name="VPC-IGW"
    }
  
}
#default rt
resource "aws_default_route_table" "vpc-drt" {
    default_route_table_id = aws_vpc.vpc.default_route_table_id

    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_internet_gateway.igw.id
    }
    tags = {
      Name="PUBLIC-RT"
    }
  
}
#Custom route table
resource "aws_route_table" "private-rt" {
    vpc_id = aws_vpc.vpc.id
    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_nat_gateway.ngw.id
    }

    tags = {
      Name="PRIVATE-RT"
    }
  
}
#subnet association
resource "aws_route_table_association" "association1" {
    subnet_id = aws_subnet.private-subnet.id
    route_table_id = aws_route_table.private-rt.id
   
  
}
#elastic ip block
resource "aws_eip" "eip" {
    domain = "vpc"
  
}
#nat block
resource "aws_nat_gateway" "ngw" {
    allocation_id = aws_eip.eip.id
    subnet_id = aws_subnet.public-subnet.id
    tags = {
      Name="NAT-GATE"
    }
  
}

#security group
resource "aws_default_security_group" "vpc-sg" {
    vpc_id = aws_vpc.vpc.id

    ingress {
        from_port        = 0
        to_port          = 0
        protocol         = "-1"
        cidr_blocks      = ["0.0.0.0/0"]

    }

    egress {
        from_port        = 0
        to_port          = 0
        protocol         = "-1"
        cidr_blocks      = ["0.0.0.0/0"]

    }
    tags = {
      Name="VPC-SG"
    }
  
}
#EC2 Machine
resource "aws_instance" "ec21" {
    ami = "ami-09a38e2e7a3cc42de"
    key_name = "nat"
    instance_type = "t3.micro"
    associate_public_ip_address = "true"
    subnet_id = aws_subnet.public-subnet.id
    vpc_security_group_ids = [ aws_default_security_group.vpc-sg.id ]
    tags = {
      Name="PUBLIC-MACHINE"
    }
  
}

resource "aws_instance" "ec2" {
    ami = "ami-09a38e2e7a3cc42de"
    key_name = "nat"
    instance_type = "t3.micro"
    subnet_id = aws_subnet.private-subnet.id
    associate_public_ip_address = "true"
    vpc_security_group_ids = [ aws_default_security_group.vpc-sg.id ]
    tags = {
      Name="PRIVATE-MACHINE"
    }
  
}