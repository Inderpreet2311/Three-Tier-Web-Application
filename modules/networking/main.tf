resource "aws_vpc" "aws_vpc" {
    cidr_block = var.vpc_cidr
    tags = merge(var.common_tags, {
        Name = "${var.name_prefix}-vpc"
    })
}