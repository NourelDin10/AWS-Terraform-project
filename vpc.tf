resource "aws_vpc" "My-vpc" {
  cidr_block = "10.0.0.0/16"
  tags = {
    Name = "Vpc-project"
  }
}

resource "aws_subnet" "Frontend-Public" {
  vpc_id            = aws_vpc.My-vpc.id
  cidr_block        = var.Public-Subnet-CIDR[0]
  availability_zone = var.availability_zone
  tags = {
    Name = "Frontend"
  }
}


resource "aws_subnet" "Backend-public" {
  vpc_id            = aws_vpc.My-vpc.id
  cidr_block        = var.Public-Subnet-CIDR[1]
  availability_zone = var.availability_zone
  tags = {
    Name = "Backend"
  }
}

resource "aws_subnet" "database-private" {
  vpc_id            = aws_vpc.My-vpc.id
  cidr_block        = var.Private-Subnet-CIDR
  availability_zone = var.availability_zone
  tags = {
    Name = "database"
  }
}
resource "aws_subnet" "database-private2" {
  vpc_id            = aws_vpc.My-vpc.id
  cidr_block        = var.Private-Subnet2-CIDR
  availability_zone = var.availability_zone_2
  tags = {
    Name = "database2"
  }
}


resource "aws_internet_gateway" "My-igw" {
  vpc_id = aws_vpc.My-vpc.id
  tags = {
    Name = "My-igw"
  }
}

resource "aws_route_table" "My-route-table" {
  vpc_id = aws_vpc.My-vpc.id
  tags = {
    Name = "My-route-table"
  }
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.My-igw.id
  }
}

resource "aws_route_table_association" "public-ass" {
  subnet_id      = aws_subnet.Frontend-Public.id
  route_table_id = aws_route_table.My-route-table.id
}

resource "aws_route_table_association" "backend-public-ass" {
  subnet_id      = aws_subnet.Backend-public.id
  route_table_id = aws_route_table.My-route-table.id
}





