output "alb_dns_name" {
  value       = aws_lb.aws00-alb.dns_name
  description = "The domain name of the load balance"
}