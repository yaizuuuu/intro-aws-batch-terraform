/*
 VPC
 */
resource "aws_vpc" "intro-aws-batch" {
  cidr_block = "10.0.0.0/16"

  enable_dns_hostnames = true
  enable_dns_support = true

  tags = {
    Name = "intro-aws-batch"
  }
}

/*
 EIP
 */
resource "aws_eip" "pri-a" {
  tags = {
    Name = "nat_pri-a"
  }
}

resource "aws_eip" "pri-c" {
  tags = {
    Name = "nat_pri-c"
  }
}

/*
 IGW
 */
resource "aws_internet_gateway" "intro-aws-batch" {
  vpc_id = aws_vpc.intro-aws-batch.id

  tags = {
    Name = "intro-aws-batch"
  }
}

/*
 Subnet
 */
resource "aws_subnet" "pub-a" {
  cidr_block = "10.0.0.0/24"
  vpc_id = aws_vpc.intro-aws-batch.id

  tags = {
    Name = "intro-aws-batch_pub-a"
  }
}

resource "aws_subnet" "pub-c" {
  cidr_block = "10.0.1.0/24"
  vpc_id = aws_vpc.intro-aws-batch.id

  tags = {
    Name = "intro-aws-batch_pub-c"
  }
}

resource "aws_subnet" "pri-a" {
  cidr_block = "10.0.2.0/24"
  vpc_id = aws_vpc.intro-aws-batch.id

  tags = {
    Name = "intro-aws-batch_pri-a"
  }
}

resource "aws_subnet" "pri-c" {
  cidr_block = "10.0.3.0/24"
  vpc_id = aws_vpc.intro-aws-batch.id

  tags = {
    Name = "intro-aws-batch_pri-c"
  }
}

/*
 NAT
 */
resource "aws_nat_gateway" "pri-a" {
  allocation_id = aws_eip.pri-a.id
  subnet_id = aws_subnet.pub-a.id

  tags = {
    Name = "pri-a"
  }
}

resource "aws_nat_gateway" "pri-c" {
  allocation_id = aws_eip.pri-c.id
  subnet_id = aws_subnet.pub-c.id

  tags = {
    Name = "pri-c"
  }
}

/*
 Route Table
 */
resource "aws_route_table" "pub-a" {
  vpc_id = aws_vpc.intro-aws-batch.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.intro-aws-batch.id
  }

  tags = {
    Name = "intro-aws-batch_pub-a"
  }
}

resource "aws_route_table" "pub-c" {
  vpc_id = aws_vpc.intro-aws-batch.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.intro-aws-batch.id
  }

  tags = {
    Name = "intro-aws-batch_pub-c"
  }
}

resource "aws_route_table" "pri-a" {
  vpc_id = aws_vpc.intro-aws-batch.id

  route {
    cidr_block = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.pri-a.id
  }

  tags = {
    Name = "intro-aws-batch_pri-a"
  }
}

resource "aws_route_table" "pri-c" {
  vpc_id = aws_vpc.intro-aws-batch.id


  route {
    cidr_block = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.pri-c.id
  }

  tags = {
    Name = "intro-aws-batch_pri-c"
  }
}

/*
 Route Table Association
 */
resource "aws_route_table_association" "pub-a" {
  route_table_id = aws_route_table.pub-a.id
  subnet_id = aws_subnet.pub-a.id
}

resource "aws_route_table_association" "pub-c" {
  route_table_id = aws_route_table.pub-c.id
  subnet_id = aws_subnet.pub-c.id
}

resource "aws_route_table_association" "pri-a" {
  route_table_id = aws_route_table.pri-a.id
  subnet_id = aws_subnet.pri-a.id
}

resource "aws_route_table_association" "pri-c" {
  route_table_id = aws_route_table.pri-c.id
  subnet_id = aws_subnet.pri-c.id
}
