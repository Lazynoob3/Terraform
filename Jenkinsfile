pipeline {
    agent any

    environment {
        AWS_CREDENTIALS = credentials('AWS_1_CREDENTAILS')
        TERRAFORM_VERSION = '1.4.6' // Specify the desired Terraform version
        PATH = "/opt/homebrew/bin:/opt/homebrew/sbin:/usr/local/bin:/System/Cryptexes/App/usr/bin:/usr/bin:/bin:/usr/sbin:/sbin:/var/run/com.apple.security.cryptexd/codex.system/bootstrap/usr/local/bin:/var/run/com.apple.security.cryptexd/codex.system/bootstrap/usr/bin:/var/run/com.apple.security.cryptexd/codex.system/bootstrap/usr/appleinternal/bin:/Users/lazynoob/bin"
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
                        unzip -o terraform.zip
                        mv terraform ~/bin/
                        rm terraform.zip
                        """
                        sh 'export PATH=$PATH:~/bin' // Ensure the new path is in the PATH
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
