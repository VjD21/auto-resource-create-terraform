# 🚀 Terraform Usage Guide  

## 📌 Notes  

### ✅ 1. Apply the Terraform Configuration  

To apply the Terraform configuration using the `variable.tfvars` file, run:  

```sh
terraform apply --auto-approve -var-file="variable.tfvars"
```  

### ✅ 2. Manually Passing Variables  

Alternatively, you can pass values manually in the following order:  

```sh
terraform apply --auto-approve \
  -var-file="variable.tfvars" \
  -var="current_project_tag=..." \
  -var="ip_range=..." \
  -var="enter_user_name_based_on_ami=..."
```  

### ✅ 3. User Selection  

- You can enter either **`ec2-user`** or **`ubuntu`** for the `enter_user_name_based_on_ami` variable.  
- The system will automatically determine the correct username based on the AMI.  

### ✅ 4. Prerequisites  

Ensure that **Terraform is installed and properly configured** before running these commands.  

---

## 🔄 Tainting a Module  

If you need to **taint** a specific module, use the following command:  

```sh
terraform taint <module_name>
```  

For example:  

```sh
terraform taint module.instance_module.aws_instance.instance
```  

---

## ⚠️ Important Instructions  

If any of these variables are left **empty**, Terraform will use the **defaults** from `variable.tf` or prompt for input.  

```hcl
current_project_tag          = "sample"
confirm_dns_update           = "no"      # Keep this as "no" because this configures my own domain.
enter_user_name_based_on_ami = "ubuntu"  # Automatically selects AMI based on this value.
ip_range                     = "130"     # Provide a value within the range of 0 to 255.
do_you_want_nat_gateway      = false     # Set to "false" if private internet access is not needed.
```

