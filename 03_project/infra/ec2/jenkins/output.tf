output "private_ip" {
  description = "The Public IP of the Instance"
  value       = aws_instance.jenkins.private_ip
}
output "jenkins_id" {
  description = "The ID of the Instance"
  value       = aws_instance.jenkins.id
}