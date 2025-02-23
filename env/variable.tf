#Enter Project Name


variable "current_project_tag" {

  description = "Note: The current project tag"
}

variable "confirm_dns_update" {
  description = "Enter 'yes' or 'no' to indicate whether to run the DNS update."
  default     = "no"
}

variable "enter_user_name_based_on_ami" {
  description = "Enter the username (e.g., 'ubuntu' or 'ec2-user'). The appropriate image will be selected based on your input."
}

variable "ip_range" {
  description = "Enter the third octet (e.g., '0.0.third_octet.0/0') to allow flexibility in subnet allocation."
}


#To avoid manual changing AMI entries, I have used a map-type variable

variable "ec2_ami_ids" {

  default = {
    ubuntu   = "ami-036841078a4b68e14"
    ec2-user = "ami-0b4624933067d393a"
  }
}


variable "t2_nano_instance_type" {

  default = "t2.nano"

}

variable "t2_micro_instance_type" {

  default = "t2.micro"

}

variable "t3_small_instance_type" {

  default = "t3.small"

}

variable "t2_medium_instance_type" {

  default = "t3.medium"

}


variable "t3a_xlarge_instance_type" {

  default = "t3a.xlarge"

}


variable "c4_2xlarge_instance_type" {

  default = "c4.2xlarge"

}

variable "c4_4xlarge_instance_type" {

  default = "c4.4xlarge"

}

variable "allowed_ports" {
  description = "List of ports to allow"
  type        = list(number)
  default     = [22, 80, 443]
}


variable "do_you_want_nat_gateway" {
  type = bool
}