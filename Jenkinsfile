pipeline {
    agent any

    environment {
        IMAGE_NAME = "hemanth1244/trend-app:latest"
        AWS_DEFAULT_REGION = "ap-south-1"
        EKS_CLUSTER = "trend-eks-cluster"
    }

    stages {

        stage('Checkout') {
            steps {
                checkout scm
            }
        }

        stage('Build Docker Image') {
            steps {
                sh 'docker build -t $IMAGE_NAME .'
            }
        }

        stage('Push Docker Image') {
            steps {
                withCredentials([usernamePassword(credentialsId: 'dockerhub-creds', usernameVariable: 'USER', passwordVariable: 'PASS')]) {
                    sh 'echo $PASS | docker login -u $USER --password-stdin'
                    sh 'docker push $IMAGE_NAME'
                }
            }
        }

        stage('Update kubeconfig') {
            steps {
                sh 'aws eks update-kubeconfig --region $AWS_DEFAULT_REGION --name $EKS_CLUSTER'
            }
        }

        stage('Deploy to EKS') {
            steps {
                sh 'kubectl apply -f k8s/namespace.yaml'
                sh 'kubectl apply -f k8s/deployment.yaml'
                sh 'kubectl apply -f k8s/service.yaml'
            }
        }

        stage('Verify Deployment') {
            steps {
                sh 'kubectl get pods -n trend'
                sh 'kubectl get svc -n trend'
            }
        }
    }
}
