resource "aws_ebs_volume" "volumecreation" {
  count= var.ec2_count
  size = var.volume_size
  type = var.volume_type
  encrypted = var.encrpted
  tags = {
    Name = var.name
  }
}
resource "aws_volume_attachment" "voumeattach"{
  
}


resource "aws_volume_attachment" "volumeattachment" {
  count       = var.ec2["ebsvolumesize"] == [""] ? 0 : length(var.ec2["ebsvolumesize"])
  device_name = element(var.ec2["devicename"], count.index)
  volume_id   = element(aws_ebs_volume.volumecreation.*.id, count.index)
  instance_id = aws_instance.ec2.id
}