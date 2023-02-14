terraform {
#  source = "tfr:///terraform-aws-modules/ec2-instance/aws?version=4.0.0"
#  source = "git::git@github.com:foo/modules.git//frontend-app?ref=v0.0.3"
  source = "../modules//instance"
}

/*include {
  path = find_in_parent_folders()
}*/

include "root" {
    path = find_in_parent_folders()
}


locals {
  env_vars = yamldecode(
  file("${find_in_parent_folders("common-environment.yaml")}"),
  )
}

dependency "security_group" {
  config_path  = "../security_group"
  mock_outputs        = {
    security_group_id = "sample-sg"
    }
}


inputs = {
  ami           = "ami-0767046d1677be5a0"
  instance_type = local.env_vars.locals.instance_type
  security_groups = [dependency.security_group.outputs.security_group_id]
  #instance_type = "t2.micro"
  tags = {
    Name = "Terragrunt Tutorial: EC2"
  }
}
