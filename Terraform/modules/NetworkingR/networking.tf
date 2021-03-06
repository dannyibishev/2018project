resource "aws_vpc" "WebSHosting" {
  cidr_block       = "172.168.0.0/16"

  tags = {
    Name = "WebSHostingVPC"
  }
}
resource "aws_subnet" "NetSubnets" {
  count             = 3
  vpc_id            = "${aws_vpc.WebSHosting.id}"
  cidr_block        = "${element(var.cidrRange, count.index)}"
  availability_zone = "${element(var.azList, count.index)}"

  tags = {
    Name = "Subnet-0${count.index + 1}"
    Owner = "Yordan Ibishev"
  }
}

resource "aws_route_table" "mainRouteTB" {
  vpc_id = "${aws_vpc.WebSHosting.id}"

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "${aws_internet_gateway.internetgw.id}"
  }

  tags = {
    Name = "WebSHostingRoute"
  }
}

resource "aws_route_table_association" "routeassociation" {
  count          = "3"
  subnet_id      = "${element(aws_subnet.NetSubnets.*.id, count.index)}"
  route_table_id = "${aws_route_table.mainRouteTB.id}"
}

resource "aws_internet_gateway" "internetgw" {
  vpc_id = "${aws_vpc.WebSHosting.id}"
}