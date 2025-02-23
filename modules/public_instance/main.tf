#Public_ec2_info

resource "aws_instance" "instance" {


  ami                         = var.ami_id_in
  subnet_id                   = var.subnet_1_id_in
  instance_type               = var.instance_type_in
  key_name                    = var.key_name
  associate_public_ip_address = var.associate_public_ip_address
  vpc_security_group_ids      = [var.instance_sg_in]
  iam_instance_profile        = "admin"

}



