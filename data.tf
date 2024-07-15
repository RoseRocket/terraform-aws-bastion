data "aws_ec2_instance_type" "bastion_type" {
  instance_type = var.instance_type
}

data "aws_ami" "amazon-linux-2" {
  most_recent = true
  owners      = ["amazon"]
  name_regex  = "^amzn2-ami-hvm.*-gp2"

  filter {
    name   = "architecture"
    values = data.aws_ec2_instance_type.bastion_type.supported_architectures
  }
}

data "aws_subnet" "subnets" {
  count = length(var.elb_subnets)
  id    = var.elb_subnets[count.index]
}
