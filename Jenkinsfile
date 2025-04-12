pipeline {
    agent none

    stages {
        stage('Terraform Resource Create Pipeline') {
            agent { label 'worker-1' }

            stages {
                stage('User Input') {
                    steps {
                        script {
                            def inputParams = input(
                                message: 'Terraform Action - Select what you want to do:',
                                parameters: [
                                    booleanParam(name: 'APPLY_TF', defaultValue: false, description: 'Apply Terraform resources?'),
                                    booleanParam(name: 'DESTROY_TF', defaultValue: false, description: 'Destroy Terraform resources?')
                                ]
                            )
                            env.TERRAFORM_APPLY = inputParams.APPLY_TF.toString()
                            env.TERRAFORM_DESTROY = inputParams.DESTROY_TF.toString()
                        }
                    }
                }

                stage('Terraform Init & Plan') {
                    when {
                        expression { env.TERRAFORM_APPLY == 'true' }
                    }
                    steps {
                        dir('env') {
                            sh 'terraform init'
                            sh 'terraform validate'
                            sh 'terraform plan -var-file=terraform.tfvars'
                        }
                    }
                }

                stage('Terraform Apply') {
                    when {
                        expression { env.TERRAFORM_APPLY == 'true' }
                    }
                    steps {
                        dir('env') {
                            sh 'terraform apply -var-file=terraform.tfvars --auto-approve'
                        }
                    }
                }

                stage('Terraform Destroy') {
                    when {
                        expression { env.TERRAFORM_DESTROY == 'true' }
                    }
                    steps {
                        dir('env') {
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
