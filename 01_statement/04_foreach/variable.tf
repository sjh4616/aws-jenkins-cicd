variable "user_names" {
    description = "Create IAM users with these names"
    type        = list(string)
    default     = ["aws00-neo", "aws00-trinity", "aws00-morpheus"]
}