pipeline {
    agent any

    environment {
        IMAGE_NAME = "thakali-site"
        CONTAINER_NAME = "thakali-container"
    }

    stages {

        stage('Checkout Code') {
            steps {
                git branch: 'main',
                    url: 'https://github.com/pratikbishwakarma/thakali-website.git'
            }
        }

        stage('Build Docker Image') {
            steps {
                bat 'docker build -t %IMAGE_NAME% .'
            }
        }

        stage('Stop Old Container') {
            steps {
                bat '''
                docker stop %CONTAINER_NAME% || true
                docker rm %CONTAINER_NAME% || true
                '''
            }
        }

        stage('Run Docker Container') {
            steps {
                bat '''
                docker run -d ^
                --name %CONTAINER_NAME% ^
                -p 3000:80 ^
                %IMAGE_NAME%
                '''
            }
        }
    }

    post {
        success {
            echo "✅ Deployment successful!"
        }
        failure {
            echo "❌ Deployment failed!"
        }
    }
}
