resource "aws_ebs_volume" "vm" {
  size              = 40
  tags = {
    Name = "EBS-VM"
  }
}