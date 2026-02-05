pipeline {
    agent any

    environment {
        IMAGE_NAME = "thakali-site"
        CONTAINER_NAME = "thakali-container"
    }

    // Auto-trigger every 5 minutes (change as needed)
    triggers {
        cron('H/5 * * * *')
    }

    stages {

        stage('Checkout / Pull Latest Code') {
            steps {
                git branch: 'main',
                    url: 'https://github.com/pratikbishwakarma/thakali-website.git',
                    clean: true
            }
        }

        stage('Build & Deploy with Docker Compose') {
            steps {
                // Stop and remove old containers, build new image
                bat(
                    script: '''
                    docker-compose -f docker-compose.yaml down
                    docker-compose -f docker-compose.yaml build
                    docker-compose -f docker-compose.yaml up -d
                    '''
                )
            }
        }

        stage('Verify Deployment') {
            steps {
                bat('docker ps')
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
