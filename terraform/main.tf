pipeline {
    agent any

    environment {
        AWS_ACCESS_KEY_ID     = credentials('aws-access-key-id')
        AWS_SECRET_ACCESS_KEY = credentials('aws-secret-access-key')
        AWS_DEFAULT_REGION    = "ap-south-1"
    }

    stages {

        stage('Checkout Code') {
            steps {
                git branch: 'main',
                    url: 'https://github.com/YOUR_USERNAME/YOUR_TERRAFORM_REPO.git'
            }
        }

        stage('Terraform Init') {
            steps {
                sh '''
                terraform init -input=false
                '''
            }
        }

        stage('Terraform Validate') {
            steps {
                sh '''
                terraform validate
                '''
            }
        }

        stage('Terraform Plan') {
            steps {
                sh '''
                terraform plan -out=tfplan
                '''
            }
        }

        stage('Approval') {
            steps {
                input message: 'Do you want to apply Terraform changes?', ok: 'Apply'
            }
        }

        stage('Terraform Apply') {
            steps {
                sh '''
                terraform apply -input=false tfplan
                '''
            }
        }
    }

    post {
        success {
            echo "Infrastructure created successfully!"
        }
        failure {
            echo "Pipeline failed!"
        }
    }
}
