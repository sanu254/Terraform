
resource "aws_instance""EC2" {
ami = "ami-02b8269d5e85954ef"
instance_type = "t3.micro"
key_name = "saniya"
subnet_id = aws_subnet.subnet.id
associate_public_ip_address = "true"
vpc_security_group_ids = [aws_security_group.sg-01.id]
  
 tags = {
     Name = "M-01"
    
   
 } 
}

resource "aws_instance" "EC2-2" {
  ami = "ami-02b8269d5e85954ef"
  instance_type = "t3.micro"
  key_name = "saniya"
  subnet_id = aws_subnet.subnet2.id
  vpc_security_group_ids = [aws_security_group.sg-02.id]

  tags = {
    Name = "M-02"
  }
}