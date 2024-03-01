output "vpc_id" {
  value = aws_vpc.sung-vpc.id
}
output "public-subnet-2a-id" {
  value = aws_subnet.sung-public-subnet-2a.id
}
output "public-subnet-2c-id" {
  value = aws_subnet.sung-public-subnet-2c.id
}
output "private-subnet-2a-id" {
  value = aws_subnet.sung-private-subnet-2a.id
}
output "private-subnet-2c-id" {
  value = aws_subnet.sung-private-subnet-2c.id
}