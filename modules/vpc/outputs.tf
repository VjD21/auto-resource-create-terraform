output "vpc_id_out" {

  value = aws_vpc.vpc.id

}

output "subnet_1_id_out" {

  value = aws_subnet.subnet_1.id
}

output "subnet_2_id_out" {

  value = aws_subnet.subnet_2.id
}