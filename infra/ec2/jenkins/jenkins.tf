resource "aws_instance" "jenkins" {
  ami                         = "ami-09eb4311cbaecf89d"
  instance_type               = "t3.large"
  key_name                    = "aws00-key"
  private_ip                  = "10.30.64.100" 
  security_groups             = [data.terraform_remote_state.security_group.outputs.ssh_id,
                                 data.terraform_remote_state.security_group.outputs.http_id ]
  subnet_id = data.terraform_remote_state.vpc.outputs.private-subnet-2a-id

  user_data = templatefile("${path.module}/templates/userdata.sh", {})  

  tags = {
    Name = "aws00-jenkins"
  }
}