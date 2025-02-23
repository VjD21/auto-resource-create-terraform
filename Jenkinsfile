pipeline {
    agent none
    environment {
        PROJECT = "WELCOME TO Jenkins-Terraform Modules Pipeline"
        TERRAFORM_MODULE_REPO = "https://github.com/VjD21/auto-resource-create-terraform.git"
    }
    stages {
        stage('For Parallel Stages') {
            parallel {
                stage('Deploy To Development') {
                    agent { label 'jenkins-slave-dev' }
                    environment {

                        TERRAFORM_APPLY = "YES" // Set to YES to trigger apply...
                        TERRAFORM_DESTROY = "NO" // Set to YES if you want to destroy...
                    }
                    when {
                        branch 'development'
                    }
                    stages {
                        stage('Clone Terraform Modules') {
                            steps {
                                sh 'pwd'
                                sh 'rm -rf terraform-modules'
                                sh 'ls -al'
                                sh "git clone ${TERRAFORM_MODULE_REPO} terraform-modules"
                                sh 'ls -al terraform-modules/development'
                                sh 'find terraform-modules/development -name "*.tf"'
                            }
                        }
                        stage('Terraform Init & Plan') {
                            when {
                                expression {
                                    "${env.TERRAFORM_APPLY}" == 'YES'
                                }
                            }
                            steps {
                                dir('terraform-modules/development') {  // Navigate to development directory
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
                                dir('terraform-modules/development') {
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
                                dir('terraform-modules/development') {
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
