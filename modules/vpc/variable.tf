variable "vpc_cidr_in" {}
variable "subnet_01_cidr_in" {}
variable "subnet_02_cidr_in" {}
variable "subnet_03_cidr_in" {}
variable "subnet_04_cidr_in" {}
variable "project_tag_in" {}

variable "vpc_tag" {
  type    = string
  default = "vpc"
}


variable "subnet_01_tag" {
  type    = string
  default = "subnet-01"
}

variable "subnet_02_tag" {
  type    = string
  default = "subnet-02"
}

variable "subnet_03_tag" {
  type    = string
  default = "subnet-03"
}

variable "subnet_04_tag" {
  type    = string
  default = "subnet-04"
}

variable "az_zone_a" {
  type    = string
  default = "us-east-2a"
}

variable "az_zone_b" {
  type    = string
  default = "us-east-2b"
}

variable "igw_tag" {
  type    = string
  default = "igw"
}

variable "cidr_open" {
  default = "0.0.0.0/0"
}

variable "public_routetable_tag" {
  type    = string
  default = "public_route_table"

}

variable "private_routetable_tag" {
  type    = string
  default = "private_route_table"

}

variable "nat_gateway_id_in" {

}


