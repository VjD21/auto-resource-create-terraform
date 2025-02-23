resource "aws_eip" "eip" {
  domain   = "vpc"

  tags = {
    Name = "${var.project_tag_in}-eip"
  }
}


resource "aws_nat_gateway" "nat_gateway" {
  allocation_id     = aws_eip.eip.id
  subnet_id         = var.subnet_1_id_in
  connectivity_type = "public"

  tags = {
    Name = "${var.project_tag_in}-${var.nat_gateway_tag}"
  }
}