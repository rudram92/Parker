resource "aws_security_group" "vm-sg" {
  name        = "Non-Prod-SG"
  description = "Allow inbound traffic"
  vpc_id      = var.vpc.vpc_id

  ingress {
    description = "SSH from VPC"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = var.cidr_blocks
  }
    ingress {
    from_port   = "80"
    to_port     = "80"
    protocol    = "TCP"
    description = "open http for all"
    cidr_blocks = var.cidr_blocks
  }
  ingress {
    from_port   = "443"
    to_port     = "443"
    protocol    = "TCP"
    description = "open https for all"
    cidr_blocks = var.cidr_blocks
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "Non-Prod-SG"
  }
}