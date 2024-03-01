variable "web_port" {
  description = "The port will use for HTTP requests"
  type        = number
  default     = 8080
}
variable "ssh_port" {
  description = "The port will use for SSH requests"
  type        = number
  default     = 22
}