pipeline {
    agent { label 'SPRING'}
    stages {
        stage('git') {
            git branch: 'main',
                   url: 'https://github.com/maheshryali123/ansible_terraform.git'
        }
        stage('terraform') {
            sh """
            terraform init
            terraform apply -auto-approve
            """
        }
    }
}