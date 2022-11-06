resource "aws_vpc" "myvpc" {
  cidr_block = var.vpccidr
}

resource "aws_subnet" "publicsubnet" {
  count             = length(var.subnetcidr)
  vpc_id            = aws_vpc.myvpc.id
  availability_zone = var.targetaz[count.index]
  cidr_block        = var.subnetcidr[count.index]
  tags = {
    "Name" = "publicsubnet-${count.index}"
  }
}
