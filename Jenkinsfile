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
                    url: 'https://github.com/pratikbishwakarma/thakali-website.git'
            }
        }

        stage('Build & Deploy with Docker Compose') {
            steps {
                // Stop and remove old containers, build new image
                bat(
                    script: '''
                    docker-compose down
                    docker-compose up -d --force-recreate --no-deps --build thakali-site
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
