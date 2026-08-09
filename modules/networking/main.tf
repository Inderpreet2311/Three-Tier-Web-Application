resource "aws_vpc" "aws_vpc" {
    cidr_block = var.vpc_cidr
    tags = merge(var.common_tags, {
        Name = "${var.name_prefix}-vpc"
    })
}

resource "aws_subnet" "public_subnet_a" {
    vpc_id = aws_vpc.aws_vpc.id
    cidr_block = var.public_subnet_cidr_a
    availability_zone = "us-east-1a"
     tags = merge(var.common_tags, {
        Name = "${var.name_prefix}-public-subnet-a"
    })
}

resource "aws_subnet" "public_subnet_b" {
    vpc_id = aws_vpc.aws_vpc.id
    cidr_block = var.public_subnet_cidr_b
    availability_zone = "us-east-1b"
     tags = merge(var.common_tags, {
        Name = "${var.name_prefix}-public-subnet-b"
    })
}

resource "aws_subnet" "private_subnet_a" {
    vpc_id = aws_vpc.aws_vpc.id
    cidr_block = var.private_subnet_cidr_a
    availability_zone = "us-east-1a"
     tags = merge(var.common_tags, {
        Name = "${var.name_prefix}-private-subnet-a"
    })
}

resource "aws_subnet" "private_subnet_b" {
    vpc_id = aws_vpc.aws_vpc.id
    cidr_block = var.private_subnet_cidr_b
    availability_zone = "us-east-1b"
     tags = merge(var.common_tags, {
        Name = "${var.name_prefix}-private-subnet-b"
    })
}

resource "aws_internet_gateway" "aws_internet_gateway" {
    vpc_id = aws_vpc.aws_vpc.id
     tags = merge(var.common_tags, {
        Name = "${var.name_prefix}-igw"
    })
}

resource "aws_route_table" "aws_route_table" {
    vpc_id = aws_vpc.aws_vpc.id

    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_internet_gateway.aws_internet_gateway.id
    }
  tags = merge(var.common_tags, {
        Name = "${var.name_prefix}-route-table"
    })
}

resource "aws_route_table_association" "route_table_association_a" {
    subnet_id = aws_subnet.public_subnet_a.id
    route_table_id = aws_route_table.aws_route_table.id
}

resource "aws_route_table_association" "route_table_association_b" {
    subnet_id = aws_subnet.public_subnet_b.id
    route_table_id = aws_route_table.aws_route_table.id
}