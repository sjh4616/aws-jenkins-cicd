provider "aws" {
    region = "ap-northeast-2"
}
// 기본 VPC 정보
data "aws_vpc" "default" {
    default = true
}

data "aws_subnets" "example" {
    filter { 
        name = "vpc-id"  // output 이름
        values = [data.aws_vpc.default.id]
    }
}

data "aws_subnet" "example" {
    for_each = toset(data.aws_subnets.example.ids)
    id = each.value
}

output "subnet_output" {
    value = [for i in data.aws_subnet.example : i.cidr_block ]
}

// default vpc id 출력
output "vpc-id" {
    value = data.aws_vpc.default.id
}
