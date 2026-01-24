pipeline {
    agent any

    stages {
        stage('Step 1: SCM Checkout') {
            steps {
                checkout scm
            }
        }

        stage('Step 2: Terraform Init') {
            steps {
                script {
                    sh 'terraform init'
                }
            }
        }

        stage('Step 3: Terraform Plan') {
            steps {
                script {
                    sh 'terraform plan -out=tfplan'
                }
            }
        }

        stage('Step 4: Terraform Apply') {
            steps {
                script {
                    sh 'terraform apply -auto-approve tfplan'
                }
            }
        }

        stage('Step 5: Terraform Destroy') {
            steps {
                script {
                    sh 'terraform destroy -auto-approve'
                }
            }
        }
    }

    post {
        always {
            cleanWs()
        }
    }
}
