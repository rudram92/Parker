################# Key Pair ##################

module "key_pair" {
  source     = "./module/key-ec2"
  key_name   = "parker-key"
  public_key = "~/.ssh/authorized_keys"
}

############# Security Group #######################

module "security-gp" {
  source          = "./modules/sg"
  vpc_id          = ""
  cidr_blocks     = ""
  secgroupingress = var.sgroupingressrules
  secgroupegress  = var.sgroupegressrules
  sgname          = var.sgroupname
}
variable "sgroupingressrules" {}
variable "sgroupegressrules" {}
variable "sgroupname" {}

sgroupingressrules = {
  "fromport"   = ["80", "443"]
  "toport"     = ["80", "443"]
  "protocol"   = ["tcp", "tcp"]
  "cidrblocks" = ["", ""]
}

sgroupegressrules = {
  "fromport"   = [""]
  "toport"     = [""]
  "protocol"   = [""]
  "cidrblocks" = [""]
}

sgroupname = "non_production"

############# AWS instnace #########################

module "ec2_creation" {

  source = "./modules/ec2"

  ami                    = ""
  instance_type          = ""
  subnet_id              = var.subnet_id
  availability_zone      = var.availability_zone
  vpc_security_group_ids = var.aws_security_group
  key_name               = "${module.key_pair.id}"
  root_volume_type       = ""
  root_volume_size       = ""
  tags                   = ""
  disable_api_termination = ""
  
}