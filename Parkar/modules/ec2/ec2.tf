resource "aws_instance" "ec2" {
  ami                     = var.ami_id
  instance_type           = var.instance_type
  monitoring              = true
  subnet_id               = var.subnet_id
  vpc_security_group_ids  = var.aws_security_group
  disable_api_termination = var.disable_api_termination
  key_name                = var.key_name
  root_block_device {
    volume_type           = var.root_volume_type
    volume_size           = var.root_volume_size
    delete_on_termination = true
    encrypted             = true
  }

  tags = {
    Name = var.name
  }
}

resource "aws_ebs_volume" "volumecreation" {
  count= var.ec2["volume_size"] == [""] ? 0 : length(var.ec2["volume_size"])
  size = element(var.ec2["volume_size"], count.index)
  type = element(var.ec2["volume_type"],count.index)
  encrypted = var.encrypted
  tags = {
    Name = var.name
  }
}
resource "aws_volume_attachment" "voumeattach"{
  count       = var.ec2["volume_size"] == [""] ? 0 : length(var.ec2["volume_size"])
  device_name = element(var.ec2["devicename"], count.index)
  volume_id   = element(aws_ebs_volume.volumecreation.*.id, count.index) 
  instance_id = aws_instance.ec2.id
}
