output "vpc_id" {
  value = aws_vpc.main.id
}

output "public_subnet_id" {
  value = aws_subnet.public.id
}

output "private_subnet_id" {
  value = aws_subnet.private.id
}

output "internet_gateway_id" {
  value = aws_internet_gateway.gw.id
}

output "nat_gateway_id" {
  value = aws_nat_gateway.nat-gw.id
}

output "nat_eip" {
  value = aws_eip.nat.public_ip
}

output "public_route_table_id" {
  value = aws_route_table.public.id
}

output "private_route_table_id" {
  value = aws_route_table.private.id
}

output "devserver-ip" {
  value       = aws_instance.devserver.public_ip
  description = "The ip address of the dev server"
}
