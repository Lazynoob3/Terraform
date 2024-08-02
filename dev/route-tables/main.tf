resource "aws_route_table" "public" {
  vpc_id = var.vpc_id

  tags = {
    Name = "${var.vpc_name}-public-route-table"
  }
}

resource "aws_route" "public_route" {
  route_table_id         = aws_route_table.public.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = var.internet_gateway_id
}

resource "aws_route_table_association" "public" {
  count         = length(var.public_subnet_ids)
  subnet_id     = var.public_subnet_ids[count.index]
  route_table_id = aws_route_table.public.id
}

resource "aws_route_table" "private" {
  vpc_id = var.vpc_id

  tags = {
    Name = "${var.vpc_name}-private-route-table"
  }
}

resource "aws_route_table_association" "private" {
  count         = length(var.private_subnet_ids)
  subnet_id     = var.private_subnet_ids[count.index]
  route_table_id = aws_route_table.private.id
}
