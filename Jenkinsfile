pipeline {
    agent any

    environment {
        AWS_CREDENTIALS = credentials('AWS_1_CREDENTAILS')
        PATH = "/opt/homebrew/bin:$PATH" // Adjust according to your Terraform version path
    }

    stages {
        stage('Checkout') {
            steps {
                git branch: 'master', url: 'https://github.com/Lazynoob3/Terraform.git'
            }
        }

        stage('Check Terraform Installation') {
            steps {
                sh 'terraform version'
            }
        }

        stage('Terraform Validate') {
            steps {
                withAWS(credentials: 'AWS_1_CREDENTAILS', region: 'ap-south-1') {
                    sh 'cd dev && terraform validate'
                }
            }
        }

        stage('Initialize Terraform') {
            steps {
                withAWS(credentials: 'AWS_1_CREDENTAILS', region: 'ap-south-1') {
                    sh 'cd dev && terraform init -reconfigure'
                }
            }
        }

        stage('Refresh Terraform State') {
            steps {
                withAWS(credentials: 'AWS_1_CREDENTAILS', region: 'ap-south-1') {
                    sh 'cd dev && terraform refresh'
                }
            }
        }

        stage('Plan Terraform') {
            steps {
                withAWS(credentials: 'AWS_1_CREDENTAILS', region: 'ap-south-1') {
                    sh 'cd dev && terraform plan -out=tfplan'
                }
            }
        }

        stage('Apply Terraform') {
            steps {
                input message: 'Do you want to apply the changes?'
                withAWS(credentials: 'AWS_1_CREDENTAILS', region: 'ap-south-1') {
                    sh 'cd dev && terraform apply tfplan -auto-approve'
                }
            }
        }
    }

    post {
        always {
            archiveArtifacts artifacts: 'dev/terraform.tfstate', allowEmptyArchive: true
        }
    }
}
