output "public_ip" {
  description = "The Public IP of the Instance"
  value       = aws_instance.target.public_ip
}