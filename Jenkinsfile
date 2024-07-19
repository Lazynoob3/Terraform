pipeline {
    agent any

    environment {
        AWS_CREDENTIALS = credentials('AWS_1_CREDENTAILS')  // Using the provided AWS credentials ID
    }

    triggers {
        githubPullRequest {
            // Automatically trigger the pipeline when a PR is raised to the master branch
            branch('master')
        }
    }

    stages {
        stage('Checkout') {
            steps {
                git branch: 'main', url: 'https://github.com/your-repo/terraform-scripts.git'
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
