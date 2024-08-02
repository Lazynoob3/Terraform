resource "aws_subnet" "public" {
  count      = length(var.public_cidrs)
  vpc_id     = var.vpc_id
  cidr_block = var.public_cidrs[count.index]

  map_public_ip_on_launch = true

  tags = {
    Name = "${var.vpc_name}-public-subnet-${count.index + 1}"
  }
}

resource "aws_subnet" "private" {
  count      = length(var.private_cidrs)
  vpc_id     = var.vpc_id
  cidr_block = var.private_cidrs[count.index]

  tags = {
    Name = "${var.vpc_name}-private-subnet-${count.index + 1}"
  }
}
