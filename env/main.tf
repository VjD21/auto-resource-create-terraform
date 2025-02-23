data "local_file" "dns_entry" {
  filename = "${path.module}/../scripts/dns_entry.sh"
}

locals {
  dns_entry_content = data.local_file.dns_entry.content
}


locals {
  current_project_tag = var.current_project_tag
}


# We can not pass the variable into the variable block so, I have used local block instead of variable block.

locals {
  vpc_cidr       = "192.168.${var.ip_range}.0/24"
  subnet_01_cidr = "192.168.${var.ip_range}.0/28"
  subnet_02_cidr = "192.168.${var.ip_range}.16/28"
  subnet_03_cidr = "192.168.${var.ip_range}.32/28"
  subnet_04_cidr = "192.168.${var.ip_range}.48/28"
}


module "vpc_module" {

  source            = "../modules/vpc"
  vpc_cidr_in       = local.vpc_cidr
  subnet_01_cidr_in = local.subnet_01_cidr
  subnet_02_cidr_in = local.subnet_02_cidr
  subnet_03_cidr_in = local.subnet_03_cidr
  subnet_04_cidr_in = local.subnet_04_cidr
  project_tag_in    = local.current_project_tag
  nat_gateway_id_in = length(module.nat_gateway_module) > 0 ? module.nat_gateway_module[0].nat_gateway_id_out : null

}


module "sg_module" {

  source           = "../modules/sg"
  vpc_id_in        = module.vpc_module.vpc_id_out
  project_tag_in   = local.current_project_tag
  allowed_ports_in = var.allowed_ports

}

module "nat_gateway_module" {

  source         = "../modules/nat_gateway"
  count          = var.do_you_want_nat_gateway ? 1 : 0
  project_tag_in = local.current_project_tag
  subnet_1_id_in = module.vpc_module.subnet_1_id_out


}

module "instance_module" {

  source                = "../modules/public_instance"
  subnet_1_id_in        = module.vpc_module.subnet_1_id_out
  instance_sg_in        = module.sg_module.instance_sg_out
  project_tag_in        = local.current_project_tag
  instance_type_in      = var.t2_medium_instance_type
  dns_entry_content_in  = local.dns_entry_content
  confirm_dns_update_in = var.confirm_dns_update
  ami_id_in             = var.ec2_ami_ids["${var.enter_user_name_based_on_ami}"]
  linux_user_in         = var.enter_user_name_based_on_ami

}

