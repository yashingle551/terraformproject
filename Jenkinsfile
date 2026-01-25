
pipeline {
  agent any

  stages {

    stage('Checkout Code') {
      steps {
        git branch: 'main',
            url: 'https://github.com/Siddhantkadam28/TerrafromdevOPS.git'
      }
    }

    stage('Terraform Init') {
      steps {
        sh '''
          terraform version
          terraform init --reconfigure
        '''
      }
    }

    stage('Terraform Validate') {
      steps {
        sh 'terraform validate'
      }
    }

    stage('Terraform Plan') {
      steps {
        sh 'terraform plan -out=tfplan'
      }
    }

    stage('Terraform Apply') {
      steps {
        input message: 'Approve Terraform Apply?'
        sh 'terraform apply tfplan'
      }
    }
    stage('Terraform destroy') {
      steps {
        input message: 'Approve Terraform destroy?'
        sh 'terraform destroy -auto-approve'
      }
    }
  }
  
}
