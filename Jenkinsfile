pipeline {
    agent any

    environment {
        IMAGE_NAME = "vite"
        CONTAINER_NAME = "vite-container"
        PORT = "5173"
    }

    stages {
        stage('Checkout Code') {
            steps {
                echo "✅ Checking out source code from Git..."
                // Jenkins will automatically checkout code from SCM
            }
        }

        stage('Build Docker Image') {
            steps {
                script {
                    echo "🐳 Building Docker image..."
                    sh 'docker build -t $IMAGE_NAME .'
                }
            }
        }

        stage('Stop Old Container') {
            steps {
                script {
                    echo "🧹 Stopping old container (if running)..."
                    sh 'docker rm -f $CONTAINER_NAME || true'
                }
            }
        }

        stage('Run New Container') {
            steps {
                script {
                    echo "🚀 Running new container..."
                    sh 'docker run -d -p ${PORT}:80 --name $CONTAINER_NAME $IMAGE_NAME'
                }
            }
        }

        stage('Verify Deployment') {
            steps {
                script {
                    echo "🔍 Checking running containers..."
                    sh 'docker ps | grep $CONTAINER_NAME'
                }
            }
        }
    }

    post {
        success {
            echo "✅ Deployment complete! Visit your chatbot at http://<server-ip>:${PORT}"
        }
        failure {
            echo "❌ Build failed. Check Jenkins logs for details."
        }
    }
}
