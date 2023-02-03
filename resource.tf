resource "aws_vpc" "vpc" {
  cidr_block = "192.168.0.0/16"

  tags = {
    Name = "newvpc"
  }
}

resource "aws_subnet" "subnetpublic" {
    vpc_id     = aws_vpc.vpc.id
    cidr_block = "192.168.0.0/24"

    tags = {
        Name = "subnetpublic"
    }

    depends_on = [
      aws_vpc.vpc
    ]
}

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.vpc.id

  tags = {
    Name = "igwansible"
  }

  depends_on = [
    aws_vpc.vpc
  ]
}

resource "aws_route_table" "publicroute" {
  vpc_id = aws_vpc.vpc
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }
  tags = {
    Name = "publicroute"
  }

  depends_on = [
    aws_internet_gateway.igw
  ]
}

resource "aws_route_table_association" "routeasscoiation" {
    subnet_id      = aws_subnet.subnetpublic.id
    route_table_id = aws_route_table.publicroute.id
}







