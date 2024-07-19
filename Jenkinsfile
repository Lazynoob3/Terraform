pipeline {
    agent any

    environment {
        AWS_CREDENTIALS = credentials('AWS_1_CREDENTAILS')
        TERRAFORM_VERSION = '1.4.6' // Specify the desired Terraform version
    }

    stages {
        stage('Checkout') {
            steps {
                git branch: 'master', url: 'https://github.com/Lazynoob3/Terraform.git'
            }
        }

        stage('Install Terraform') {
            steps {
                script {
                    def terraformExists = sh(script: 'which terraform', returnStatus: true) == 0
                    if (!terraformExists) {
                        sh """
                        curl -o terraform.zip https://releases.hashicorp.com/terraform/${TERRAFORM_VERSION}/terraform_${TERRAFORM_VERSION}_darwin_amd64.zip
                        unzip terraform.zip
                        mv terraform /usr/local/bin/
                        rm terraform.zip
                        """
                    }
                }
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
                    sh 'cd environments/dev && terraform init'
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
