output "vpc_id" {
  value = aws_vpc.aws00-vpc.id
}
output "public-subnet-2a-id" {
  value = aws_subnet.aws00-public-subnet-2a.id 
}
output "public-subnet-2c-id" {
  value = aws_subnet.aws00-public-subnet-2c.id 
}
output "private-subnet-2a-id" {
  value = aws_subnet.aws00-private-subnet-2a.id
}
output "private-subnet-2c-id" {
  value = aws_subnet.aws00-private-subnet-2c.id 
}