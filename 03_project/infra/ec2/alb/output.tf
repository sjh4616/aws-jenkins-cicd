output "alb_dns_name" {
  value       = aws_lb.sung-alb.dns_name
  description = "The domain name of the load balance"
}