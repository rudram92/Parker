resource "aws_instance" "Non-prod" {
  ami               = var.ami_id
  instance_type     = var.instance_type
  monitoring        = true
  subnet_id         = var.subnet_id
  availability_zone = var.availability_zone
  vpc_security_group_ids = var.aws_security_group
  disable_api_termination = true
  key_name          = var.key_name
  root_block_device {
  volume_type = var.volume_type
  volume_size = var.volume_size
  delete_on_termination = true
  encrypted             = true
  }
  
  tags = {
    Name = var.name
  }
}