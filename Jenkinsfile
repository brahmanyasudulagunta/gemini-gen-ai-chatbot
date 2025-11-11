pipeline {
    agent any
    
    // Define environment variables, primarily for the Docker Compose service name.
    environment {
        // Use 'compose' instead of 'compose up' to allow for cleanup steps
        DOCKER_COMPOSE = 'docker-compose' 
        CONTAINER_NAME = 'gemini_frontend'
    }

    stages {
        stage('Declarative: Checkout SCM') {
            steps {
                checkout scm
            }
        }

        stage('Build') {
            steps {
                // Ensure a clean build of the service image
                sh "${DOCKER_COMPOSE} build"
            }
        }

        stage('Deploy') {
            steps {
                script {
                    // --- Recommended Fix/Workaround for 'KeyError: ContainerConfig' ---
                    // This is a common fix for the Docker Compose V1 bug when dealing 
                    // with image metadata changes between builds.
                    
                    // 1. Explicitly stop and remove the old container instance. 
                    // The '|| true' prevents the pipeline from failing if the container 
                    // doesn't exist yet (e.g., on the very first run).
                    echo "Attempting to stop and remove old container instances..."
                    sh "${DOCKER_COMPOSE} down --remove-orphans || true"

                    // 2. Deploy the new service using the 'up' command.
                    // If the Key Error persists, you may need to add --force-recreate here.
                    echo "Deploying new container..."
                    sh "${DOCKER_COMPOSE} up -d"
                }
            }
        }
    }
}
