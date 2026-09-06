# DevOps Assignment

## Overview

This project demonstrates a basic DevOps workflow for a Python web application.

The project includes:

* Python application
* Automated tests using Pytest
* Docker containerization
* Kubernetes deployment configuration
* GitHub Actions CI workflow
* Linux and networking documentation
* AWS deployment documentation

---

## Project Structure

```text
devops-assignment/
├── .github/
│   └── workflows/
│       └── ci.yml
├── app/
│   ├── main.py
│   └── requirements.txt
├── docs/
│   ├── aws-deployment.md
│   └── linux-networking.md
├── k8s/
│   ├── configmap.yaml
│   ├── deployment.yaml
│   └── service.yaml
├── tests/
│   └── test_main.py
├── Dockerfile
├── .dockerignore
├── .gitignore
└── README.md
```

---

# Prerequisites

The following tools are required to run the project:

* Python
* Docker Desktop
* Git
* Kubernetes / Minikube (for Kubernetes deployment)

Check the installed versions:

```bash
python --version
docker --version
git --version
```

---

# Run the Application Locally

## 1. Install Dependencies

From the project root directory, run:

```bash
python -m pip install -r app/requirements.txt
```

## 2. Start the Application

Run:

```bash
python app/main.py
```

The application will be available at:

```text
http://localhost:5000
```

---

# Application Endpoints

## Home Endpoint

```text
GET /
```

Open in a browser:

```text
http://localhost:5000
```

## Health Check Endpoint

```text
GET /health
```

Open in a browser:

```text
http://localhost:5000/health
```

This endpoint can be used for application health checks.

---

# Run Tests

The project uses Pytest for automated testing.

Run:

```bash
python -m pytest
```

A successful test run should show that all tests have passed.

---

# Docker

## Build the Docker Image

From the project root directory:

```bash
docker build -t devops-assignment .
```

## Run the Docker Container

Run:

```bash
docker run -p 5000:5000 devops-assignment
```

The application will be available at:

```text
http://localhost:5000
```

The health endpoint is available at:

```text
http://localhost:5000/health
```

To stop the container, press:

```text
CTRL + C
```

---

# Kubernetes Deployment

The Kubernetes configuration files are located in:

```text
k8s/
```

The directory contains:

* `configmap.yaml` – Application configuration
* `deployment.yaml` – Application deployment configuration
* `service.yaml` – Application service configuration

## Start Minikube

```bash
minikube start --driver=docker
```

## Apply Kubernetes Configuration

From the project root directory:

```bash
kubectl apply -f k8s/
```

## Check Deployment

Check Pods:

```bash
kubectl get pods
```

Check Services:

```bash
kubectl get services
```

Check Deployments:

```bash
kubectl get deployments
```

## Access the Application

If using Minikube:

```bash
minikube service devops-assignment-service
```

---

# GitHub Actions CI

The GitHub Actions workflow is located at:

```text
.github/workflows/ci.yml
```

The CI workflow can automatically:

1. Check out the source code.
2. Set up Python.
3. Install dependencies.
4. Run automated tests.
5. Build the Docker image.

The workflow runs when changes are pushed to the configured GitHub branches.

---

# Documentation

Additional documentation is available in the `docs` directory.

## Linux and Networking

```text
docs/linux-networking.md
```

This document covers:

* CPU, memory, and disk checks
* Running processes
* Listening ports
* Network interfaces and routes
* Application logs
* IP addresses and networking concepts
* TCP and HTTP basics
* AWS Security Groups

## AWS Deployment

```text
docs/aws-deployment.md
```

This document describes a proposed AWS deployment architecture using:

* GitHub Actions
* Amazon ECR
* Amazon ECS with Fargate
* Application Load Balancer
* IAM
* VPC
* Security Groups
* CloudWatch

---

# Security Considerations

The following security practices are followed:

* Sensitive credentials should not be committed to GitHub.
* Secrets should not be stored in source code.
* Docker containers should run with appropriate permissions.
* Security Groups should allow only required traffic.
* IAM permissions should follow the principle of least privilege.

---

# Project Workflow

The overall DevOps workflow is:

```text
Developer
    |
    v
GitHub Repository
    |
    v
GitHub Actions
    |
    |-- Run Tests
    |
    |-- Build Docker Image
    v
Docker Image
    |
    v
Kubernetes Deployment
```

For a proposed AWS deployment:

```text
GitHub
   |
   v
GitHub Actions
   |
   v
Amazon ECR
   |
   v
Amazon ECS with Fargate
   |
   v
Application Load Balancer
   |
   v
Users
```

---

# Author

**Jigisha Mhapasekar**

# Conclusion

This project demonstrates a complete basic DevOps workflow, including application testing, Docker containerization, Kubernetes deployment, CI automation, Linux and networking concepts, and a proposed AWS deployment architecture.
