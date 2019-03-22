output "vpc_id" {
  value = "${aws_vpc.WebSHosting.id}"
}

output "subnet_ids" {
  value = "${aws_subnet.NetSubnets.*.id}"
}