pipeline {
    agent none

    stages {
        stage('For Parallel Stages') {
            parallel {
                stage('Deploy To Development') {
                    agent { label 'jenkins-slave-dev' }
                    environment {

                        TERRAFORM_APPLY = "YES" // Set to YES to trigger apply....
                        TERRAFORM_DESTROY = "NO" // Set to YES if you want to destroy...
                    }
                    when {
                        branch 'production'
                    }
                    stages {
                        stage('Clone Terraform Modules') {
                            steps {
                                sh 'pwd'
                                sh 'rm -rf terraform-modules'
                                sh 'ls -al'
                                sh "git clone https://github.com/VjD21/auto-resource-create-terraform.git -b production terraform-modules"
                                sh 'ls -al terraform-modules/'
                                sh 'find terraform-modules/ -name "*.tf"'
                            }
                        }
                        stage('Terraform Init & Plan') {
                            when {
                                expression {
                                    "${env.TERRAFORM_APPLY}" == 'YES'
                                }
                            }
                            steps {
                                dir('terraform-modules/env') {  // Navigate to development directory
                                    sh 'terraform init'
                                    sh 'terraform validate'
                                    sh 'terraform plan -var-file=terraform.tfvars'
                                }
                            }
                        }
                        stage('Terraform Apply') {
                            when {
                                expression {
                                    "${env.TERRAFORM_APPLY}" == 'YES'
                                }
                            }
                            steps {
                                dir('terraform-modules/env') {
                                    sh 'terraform apply -var-file=terraform.tfvars --auto-approve'
                                }
                            }
                        }
                        stage('Terraform Destroy') {
                            when {
                                expression {
                                    "${env.TERRAFORM_DESTROY}" == 'YES'
                                }
                            }
                            steps {
                                dir('terraform-modules/env') {
                                    sh 'terraform init'
                                    sh 'terraform validate'
                                    sh 'terraform destroy -var-file=terraform.tfvars --auto-approve'
                                }
                            }
                        }
                    }
                }
            }
        }
    }
}
