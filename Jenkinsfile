pipeline {
    agent { label 'SPRING'}
    stages {
        stage('git') { 
            steps {
            git branch: 'main',
                   url: 'https://github.com/maheshryali123/ansible_terraform.git'
            }
        }
        stage('terraform') {
            steps{
            sh """
            terraform init
            terraform apply -auto-approve
            """
            }
        }
    }
}