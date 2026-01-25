pipeline {
    agent any

    environment {
        AWS_ACCESS_KEY_ID     = credentials('aws-access-key-id')
        AWS_SECRET_ACCESS_KEY = credentials('aws-secret-access-key')
        AWS_DEFAULT_REGION    = "eu-north-1"
    }

    stages {

        stage('Step 1: SCM Checkout') {
            steps {
                checkout scm
            }
        }

        stage('Step 2: Terraform Init') {
            steps {
                sh 'terraform init -reconfigure'
            }
        }

        stage('Step 3: Terraform Plan') {
            steps {
                sh 'terraform plan -out=tfplan'
            }
        }

        stage('Step 4: Terraform Apply') {
            steps {
                sh 'terraform apply -auto-approve tfplan'
            }
        }

        stage('Step 5: Terraform Destroy (Disabled)') {
            when {
                expression { false }
            }
            steps {
                sh 'terraform destroy -auto-approve'
            }
        }
    }

    post {
        always {
            deleteDir()   // safer than cleanWs()
        }
    }
}
