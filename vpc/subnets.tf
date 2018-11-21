# Public Subnets - each in a diff AZ
resource "aws_subnet" "public" {
  count = "${length(var.availability_zones)}"
  cidr_block = "${cidrsubnet(var.cidr_block, 8, count.index)}"
  vpc_id = "${aws_vpc.main.id}"
  availability_zone = "${element(var.availability_zones, count.index)}"
  map_public_ip_on_launch = true

  tags {
    "Name" = "${var.name_prefix} Public Subnet - ${element(var.availability_zones, count.index)}"
  }
}

# Private subnets - each in diff AZ
resource "aws_subnet" "private" {
  count = "${length(var.availability_zones)}"
  # consider CIDR blocks allocated to public subnets
  cidr_block = "${cidrsubnet(var.cidr_block, 8, count.index + length(var.availability_zones))}"
  vpc_id = "${aws_vpc.main.id}"
  availability_zone = "${element(var.availability_zones, count.index)}"
  map_public_ip_on_launch = false

  tags {
    "Name" = "${var.name_prefix} Private Subnet - ${element(var.availability_zones, count.index)}"
  }
}

# Nat Gateways. Separate gw in each AZ. give each NAT GW an Elastic IP
resource "aws_eip" "nat" {
  count = "${length(var.availability_zones)}"
  vpc = true

  tags {
    "Name" = "${var.name_prefix} EIP"
  }
}

resource "aws_nat_gateway" "main" {
  count = "${length(var.availability_zones)}"
  allocation_id = "${element(aws_eip.nat.*.id, count.index)}"
  subnet_id = "${element(aws_subnet.public.*.id, count.index)}"

  tags {
    "Name" = "${var.name_prefix} NAT - ${element(var.availability_zones, count.index)}"
  }
}
