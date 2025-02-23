#Public_ec2_info

resource "aws_instance" "instance" {


  ami                         = var.ami_id_in
  subnet_id                   = var.subnet_1_id_in
  instance_type               = var.instance_type_in
  key_name                    = var.key_name
  associate_public_ip_address = var.associate_public_ip_address
  vpc_security_group_ids      = [var.instance_sg_in]
  iam_instance_profile        = "admin"



  provisioner "file" {

    content     = var.dns_entry_content_in
    destination = "dns_entry.sh"
  }


  provisioner "file" {
    source      = "${path.module}/../../scripts/aws_cli.sh"
    destination = "aws_cli.sh"
  }



#Intha type provisioner touch la vachikanum nu try panni erukka avulotha


  provisioner "local-exec" { 
    command = "echo Welcome_$(date +'%Y%m%d_%H%M%S')"
  }


  provisioner "local-exec" {
    command = <<EOF
      printf "Private IP: ${self.private_ip}\nUsername: ${var.linux_user_in}\n" > current_instance_info.txt
    EOF
  }

  connection {
    type        = "ssh"
    user        = var.linux_user_in
    private_key = file("/home/e1087/.pri_ohio.pem")
    host        = self.public_ip
  }

  provisioner "remote-exec" {
    inline = [
      "sudo hostnamectl set-hostname ${var.project_tag_in}.vijaydurai3.site",
      "bash aws_cli.sh",
      "sleep 5"
    ]


    connection {
      type        = "ssh"
      user        = var.linux_user_in
      private_key = file("/home/e1087/.pri_ohio.pem")
      host        = self.public_ip
    }
  }



  tags = {
    Name = "${var.project_tag_in}${var.instance_tag}"
  }


}

resource "null_resource" "dns_re-entry" {

  count = var.confirm_dns_update_in == "yes" ? 1 : 0


  triggers = {
    id = timestamp()
  }

  provisioner "remote-exec" {
    inline = [
      "bash dns_entry.sh",
    ]


    connection {
      type        = "ssh"
      user        = var.linux_user_in
      private_key = file("/home/e1087/.pri_ohio.pem")
      host        = aws_instance.instance.public_ip
    }

  }

}



