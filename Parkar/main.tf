################# Key Pair ##################

module "key_pair"{
  source = "./module/key-ec2"  
  key_name   = "parker-key"
  public_key =  "~/.ssh/authorized_keys"
}

############# Security Group #######################

module "security-gp"{
    source = "./modules/sg"
    vpc_id=""
    cidr_blocks=""

}

############# AWS instnace #########################

module "ec2_creation" {

  source = "./modules/ec2"

  ami               = ""
  instance_type     = ""
  subnet_id         = var.subnet_id
  availability_zone = var.availability_zone
  vpc_security_group_ids = var.aws_security_group
  key_name = "${module.key_pair.id}"
}