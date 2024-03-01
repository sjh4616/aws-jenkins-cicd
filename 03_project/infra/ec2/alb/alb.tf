# 로드밸런스
resource "aws_lb" "sung-alb" {
  name               = "sung-alb"
  load_balancer_type = "application"
  subnets = [data.terraform_remote_state.vpc.outputs.public-subnet-2a-id,
             data.terraform_remote_state.vpc.outputs.public-subnet-2c-id]
  security_groups = [data.terraform_remote_state.security_group.outputs.http_id]
}

# 로드밸런스 리스너 - jenkins
resource "aws_lb_listener" "jenkins_http" {
  load_balancer_arn = aws_lb.sung-alb.arn
  port              = var.http_port
  protocol          = "HTTP"

  default_action {
    type = "fixed-response"

    fixed_response {
      content_type = "text/plain"
      message_body = "404: page not found"
      status_code  = 404
    }
  }
}

# 대상그룹 - Jenkins EC2
resource "aws_lb_target_group" "jenkins" {
  name     = "sung-jenkins"
  target_type = "instance"
  port     = var.http_port
  protocol = "HTTP"
  vpc_id   = data.terraform_remote_state.vpc.outputs.vpc_id

  health_check {
    path                = "/"
    protocol            = "HTTP"
    matcher             = "200"
    interval            = 15
    timeout             = 3
    healthy_threshold   = 2
    unhealthy_threshold = 2
  }
}
# 대상그룹이 인스턴스 일때 
resource "aws_lb_target_group_attachment" "jenkins" {
  target_group_arn = aws_lb_target_group.jenkins.arn
  target_id        = data.terraform_remote_state.jenkins_instance.outputs.jenkins_id
  port             = var.http_port
}

# 로드밸런스 리스너 룰 - Jenkins
resource "aws_lb_listener_rule" "jenkins" {
  listener_arn = aws_lb_listener.jenkins_http.arn
  priority     = 100

  action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.jenkins.arn
  }

  condition {
    path_pattern {
      values = ["*"]
    }
  }
}