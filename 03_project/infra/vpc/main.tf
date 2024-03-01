resource "aws_vpc" "sung-vpc" {
  cidr_block           = var.vpc_cidr
  instance_tenancy     = "default"
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = {
    Name = "sung-vpc"
  }
}

//--- 서브넷 생성 --------------------------------
// ap-northeast-2a
resource "aws_subnet" "sung-public-subnet-2a" {
  vpc_id            = aws_vpc.sung-vpc.id
  cidr_block        = var.public_subnet[0]
  availability_zone = var.azs[0]

  tags = {
    Name = "sung-public-subnet-2a"
  }
}
resource "aws_subnet" "sung-private-subnet-2a" {
  vpc_id            = aws_vpc.sung-vpc.id
  cidr_block        = var.private_subnet[0]
  availability_zone = var.azs[0]

  tags = {
    Name = "sung-private-subnet-2a"
  }
}

// ap-northeast-2c
resource "aws_subnet" "sung-public-subnet-2c" {
  vpc_id            = aws_vpc.sung-vpc.id
  cidr_block        = var.public_subnet[1]
  availability_zone = var.azs[1]

  tags = {
    Name = "sung-public-subnet-2c"
  }
}
resource "aws_subnet" "sung-private-subnet-2c" {
  vpc_id            = aws_vpc.sung-vpc.id
  cidr_block        = var.private_subnet[1]
  availability_zone = var.azs[1]

  tags = {
    Name = "sung-private-subnet-2c"
  }
}

// 인터넷 게이트웨이
resource "aws_internet_gateway" "sung-igw" {
  vpc_id = aws_vpc.sung-vpc.id

  tags = {
    Name = "sung-igw"
  }
}

// EIP
resource "aws_eip" "sung-eip" {
  domain     = "vpc"
  depends_on = [aws_internet_gateway.sung-igw]
  lifecycle {
    create_before_destroy = true
  }

  tags = {
    Name = "sung-eip"
  }
}

// NAT 게이트웨이
resource "aws_nat_gateway" "sung-nat" {
  allocation_id = aws_eip.sung-eip.id
  subnet_id     = aws_subnet.sung-public-subnet-2a.id
  depends_on    = [aws_internet_gateway.sung-igw]

  tags = {
    Name = "sung-nat"
  }
}

// 라우터
# public route table
resource "aws_default_route_table" "sung-public-rt-table" {
  default_route_table_id = aws_vpc.sung-vpc.default_route_table_id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.sung-igw.id
  }
  tags = {
    Name = "sung-public-rt-table"
  }
}

resource "aws_route_table_association" "sung-public-rt-2a" {
  subnet_id      = aws_subnet.sung-public-subnet-2a.id
  route_table_id = aws_default_route_table.sung-public-rt-table.id
}

resource "aws_route_table_association" "sung-public-rt-2c" {
  subnet_id      = aws_subnet.sung-public-subnet-2c.id
  route_table_id = aws_default_route_table.sung-public-rt-table.id
}

# private route table
resource "aws_route_table" "sung-private-rt-table" {
  vpc_id = aws_vpc.sung-vpc.id
  tags = {
    Name = "sung-private-rt-table"
  }
}

# private route
resource "aws_route" "sung-private-rt" {
  route_table_id         = aws_route_table.sung-private-rt-table.id
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = aws_nat_gateway.sung-nat.id
}

resource "aws_route_table_association" "sung-private-rt-2a" {
  subnet_id      = aws_subnet.sung-private-subnet-2a.id
  route_table_id = aws_route_table.sung-private-rt-table.id
}

resource "aws_route_table_association" "sung-private-rt-2c" {
  subnet_id      = aws_subnet.sung-private-subnet-2c.id
  route_table_id = aws_route_table.sung-private-rt-table.id
}

