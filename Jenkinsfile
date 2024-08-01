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

        stage('Initialize Terraform') {
            steps {
                withAWS(credentials: 'AWS_1_CREDENTAILS', region: 'us-east-1') {
                    sh 'cd environments/dev && terraform init -reconfigure'
                }
            }
        }

        stage('Plan Terraform') {
            steps {
                withAWS(credentials: 'AWS_1_CREDENTAILS', region: 'us-east-1') {
                    sh 'cd environments/dev && terraform plan'
                }
            }
        }

        stage('Apply Terraform') {
            steps {
                input message: 'Do you want to apply the changes?'
                withAWS(credentials: 'AWS_1_CREDENTAILS', region: 'us-east-1') {
                    sh 'cd environments/dev && terraform apply -auto-approve'
                }
            }
        }
    }

    post {
        always {
            archiveArtifacts artifacts: 'environments/dev/terraform.tfstate', allowEmptyArchive: true
        }
    }
}
