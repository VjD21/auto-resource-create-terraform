#If any of these variables are left empty, Terraform will use the defaults (variable.tf) or prompt for input.

current_project_tag          = "terraform"    # Anything you want 
confirm_dns_update           = "yes"      # If you don't have your own domain, keep this value as "no".
enter_user_name_based_on_ami = "ubuntu"    # If you enter "ec2-user," it will automatically select the Amazon AMI; the same applies for "ubuntu."
ip_range                     = "147"    # Provide a value within the range of 0 to 255.
do_you_want_nat_gateway      = false     # If you don't need private internet access, keep this value as "false".

