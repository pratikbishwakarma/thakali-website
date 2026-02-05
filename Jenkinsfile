pipeline {
    agent any

    environment {
        IMAGE_NAME = "thakali-site"
        CONTAINER_NAME = "thakali-container"
    }

    // Trigger: automatically run every 1 minute
    triggers {
        cron('H/1 * * * *') // H/1 means every 1 minute (Jenkins hashes H for load balancing)
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
                bat script: 'docker build -t %IMAGE_NAME% .'
            }
        }

        stage('Stop Old Container') {
            steps {
                bat(
                    script: '''
                    docker stop %CONTAINER_NAME%
                    docker rm %CONTAINER_NAME%
                    ''',
                    returnStatus: true
                )
            }
        }

        stage('Run Docker Container') {
            steps {
                bat(
                    script: '''
                    docker run -d ^
                    --name %CONTAINER_NAME% ^
                    -p 80:80 ^
                    %IMAGE_NAME%
                    '''
                )
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
