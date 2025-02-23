variable "ami_id_in" {}
variable "instance_type_in" {}
variable "subnet_1_id_in" {}
variable "instance_sg_in" {}
variable "project_tag_in" {}
variable "confirm_dns_update_in" {}
variable "linux_user_in" {}


variable "dns_entry_content_in" {
  type = string
}

variable "instance_tag" {
  type    = string
  default = ""
}

variable "key_name" {
  default = "pri_ohio"
}

variable "associate_public_ip_address" {
  default = "true"
}





