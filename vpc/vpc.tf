# This contains the codes that will create the vpc resource 

#VPC
resource "aws_vpc" "main" {
  cidr_block = var.vpc_cidr_block
  tags = merge(var.tags, {
    Name = "${var.tags["project"]}-${var.tags["application"]}-${var.tags["environment"]}-vpc"
    
  })

}
#PUBLIC SUBNETS
resource "aws_subnet" "public_subnet1" {
  vpc_id     = aws_vpc.main.id
  cidr_block = var.public_subnet1_cidr_block
  availability_zone = var.availability_zones[0]
  map_public_ip_on_launch = true #Default is false. this is an argument to make a subnet public. Just beacuse we call it public subnet does not make it pub untill we Specify true to indicate that instances launched into the subnet should be assigned a public IP address. 
  tags = merge(var.tags, {
    Name = "${var.tags["project"]}-${var.tags["application"]}-${var.tags["environment"]}-public_subnet1"
  })
}

resource "aws_subnet" "public_subnet2" {
  vpc_id     = aws_vpc.main.id
  cidr_block = var.public_subnet2_cidr_block
  availability_zone = var.availability_zones[1]
  map_public_ip_on_launch = true
  tags = merge(var.tags, {
    Name = "${var.tags["project"]}-${var.tags["application"]}-${var.tags["environment"]}-public_subnet2"
  })
}

#PRIVATE SUBNETS
resource "aws_subnet" "private_subnet1" {
  vpc_id     = aws_vpc.main.id
  cidr_block = var.private_subnet1_cidr_block
  availability_zone = var.availability_zones[0]
  tags = merge(var.tags, {
    Name = "${var.tags["project"]}-${var.tags["application"]}-${var.tags["environment"]}-private_subnet1"
  })  
}
resource "aws_subnet" "private_subnet2" {
  vpc_id     = aws_vpc.main.id
  cidr_block = var.private_subnet2_cidr_block
  availability_zone = var.availability_zones[1] 
  tags = merge(var.tags, {
    Name = "${var.tags["project"]}-${var.tags["application"]}-${var.tags["environment"]}-private_subnet2"
  })   
}

#IGW CREATION
resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.main.id   

  tags = merge(var.tags, {
    Name = "${var.tags["project"]}-${var.tags["application"]}-${var.tags["environment"]}-igw"
  })
}

# PUBLIC ROUTE TABLE
resource "aws_route_table" "public_route_table" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.gw.id
  }

  tags = merge(var.tags, {
    Name = "${var.tags["project"]}-${var.tags["application"]}-${var.tags["environment"]}-public-rt"
  })
}

# PUBLIC ROUTE TABLE ASSOCIATION 
resource "aws_route_table_association" "public_subnet1_association" {
  subnet_id      = aws_subnet.public_subnet1.id
  route_table_id = aws_route_table.public_route_table.id
}

resource "aws_route_table_association" "public_subnet2_association" {
  subnet_id      = aws_subnet.public_subnet2.id
  route_table_id = aws_route_table.public_route_table.id  #same route table
}

#EIP
resource "aws_eip" "eip" {
  domain   = "vpc"
  tags = merge(var.tags, {
    Name = "${var.tags["project"]}-${var.tags["application"]}-${var.tags["environment"]}-eip"
  })
}

#NAT GATEWAY  (Note that NAT GW is usually launched in PubSub, but configured in PRIV)

resource "aws_nat_gateway" "nat_gw" {
  allocation_id = aws_eip.eip.id
  subnet_id     = aws_subnet.public_subnet1.id

  tags = merge(var.tags, {
    Name = "${var.tags["project"]}-${var.tags["application"]}-${var.tags["environment"]}-nat-gw"
  })
  # To ensure proper ordering, it is recommended to add an explicit dependency
  # on the Internet Gateway for the VPC.
  # Depends_on determins creation order.  
  depends_on = [aws_eip.eip, aws_subnet.public_subnet1]
}


# PRIVATE ROUTE TABLE
resource "aws_route_table" "private_route_table" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_nat_gateway.nat_gw.id
  }

  tags = merge(var.tags, {
    Name = "${var.tags["project"]}-${var.tags["application"]}-${var.tags["environment"]}-private-rt"
  })
}

# PRIVATE ROUTE TABLE ASSOCIATION 
resource "aws_route_table_association" "private_subnet1_association" {
  subnet_id      = aws_subnet.private_subnet1.id
  route_table_id = aws_route_table.private_route_table.id
}

resource "aws_route_table_association" "private_subnet2_association" {
  subnet_id      = aws_subnet.private_subnet2.id
  route_table_id = aws_route_table.private_route_table.id
}