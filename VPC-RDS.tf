resource  "aws_vpc" "vnet" {
    cidr_block = "192.168.0.0/16"
    tags = {
        Name = "vpc-b39"

    }
}

resource "aws_subnet" "public" {
    vpc_id = aws_vpc.vnet.id
    cidr_block = "192.168.0.0/25"
    availability_zone = "us-east-1a"
    map_public_ip_on_launch = true
    tags = {
      Name = "public-subnet-nginix"
    }
}
resource "aws_subnet" "public-1" {
    vpc_id = aws_vpc.vnet.id
    cidr_block = "192.168.4.0/25"
    availability_zone = "us-east-1b"
    map_public_ip_on_launch = true
    tags = {
      Name = "public-subnet-nginix"
    }
}


resource "aws_internet_gateway" "nnet" {
    vpc_id = aws_vpc.vnet.id
  
}

resource "aws_route_table" "rt-public" {
    vpc_id = aws_vpc.vnet.id
 route  {
    gateway_id = aws_internet_gateway.nnet.id 
    cidr_block = "0.0.0.0/0"
 }
}

resource "aws_route_table_association" "pname" {
    subnet_id = aws_subnet.public.id
    route_table_id = aws_route_table.rt-public.id
  
}

resource "aws_security_group" "sg" {
    name = "ag-b39"
    vpc_id = aws_vpc.vnet.id

    ingress {
        from_port = 22
        to_port =22
        protocol = "tcp"
        cidr_blocks = [ "0.0.0.0/0" ]
    }
    ingress {
        from_port = 80
        to_port = 80
        protocol = "tcp"
        cidr_blocks = [ "0.0.0.0/0" ]
    }
    egress {
        from_port = 0
        to_port = 0
        protocol = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }
}

resource "aws_instance" "name" {
    ami = "ami-0866a3c8686eaeeba"

    instance_type = "t2.micro"
    subnet_id = aws_subnet.public.id
    vpc_security_group_ids = [aws_security_group.sg.id]
  
}

resource "aws_db_instance" "default" {
  allocated_storage    = 10
  db_name              = "mydb"
  engine               = "mysql"
  engine_version       = "8.0"
  instance_class       = "db.t3.micro"
  username             = "priya"
  password             = "piyu123"
  skip_final_snapshot  = true
}

resource "aws_db_subnet_group" "default" {
  name       = "main"
  subnet_ids = [aws_subnet.public.id, aws_subnet.public-1.id]

  tags = {
    Name = "My DB subnet group"
  }
}
