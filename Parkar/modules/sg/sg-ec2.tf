resource "aws_security_group" "vm_sg" {
  name        = var.sgname
  description = "Allow inbound traffic"
  vpc_id      = var.vpc.vpc_id
}
resource "aws_security_group_rule" "sg_ingress" {
  type              = "ingress"
  count             = length(var.sg_ingress["cidrblocks"])
  from_port         = element(var.sg_ingress["fromport"], count.index)
  to_port           = element(var.sg_ingress["toport"], count.index)
  protocol          = element(var.sg_ingress["protocol"], count.index)
  cidr_blocks       = [element(var.sg_ingress["cidrblocks"], count.index)]
  security_group_id = aws_security_group.vm_sg.id
}

resource "aws_security_group_rule" "sg_egress" {
  type              = "egress"
  count             = length(var.sg_egress["cidrblocks"])
  from_port         = element(var.sg_egress["fromport"], count.index)
  to_port           = element(var.sg_egress["toport"], count.index)
  protocol          = element(var.sg_egress["protocol"], count.index)
  cidr_blocks       = [element(var.sg_egress["cidrblocks"], count.index)]
  security_group_id = aws_security_group.vm_sg.id
}