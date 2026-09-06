# AWS Deployment Approach

## 1. Overview

This document describes how the DevOps Assignment application could be deployed to AWS.

The application is containerized using Docker.

The proposed deployment flow is:

```text
Developer
    |
    v
GitHub Repository
    |
    v
GitHub Actions
    |
    v
Docker Image
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

An actual AWS deployment is optional for this assignment. This document explains the proposed implementation approach.

---

## 2. Chosen AWS Runtime

The selected AWS runtime is **Amazon ECS with AWS Fargate**.

Amazon ECS is a container orchestration service, and AWS Fargate allows containers to run without managing EC2 servers.

ECS with Fargate was selected because:

* It is designed for running containers.
* It integrates with Amazon ECR.
* It does not require managing EC2 servers.
* It supports multiple running application instances.
* It integrates with Application Load Balancers and CloudWatch.

---

## 3. AWS Architecture

The proposed architecture is:

```text
                         Internet
                            |
                            v
                  Application Load Balancer
                            |
                            v
                     Amazon ECS Service
                       /            \
                      v              v
                 ECS Task 1      ECS Task 2
                      \              /
                       \            /
                        v          v
                    Docker Application


Developer
    |
    v
GitHub Repository
    |
    v
GitHub Actions
    |
    v
Amazon ECR
    |
    v
ECS pulls Docker Image
```

The ECS Service manages the running application tasks.

---

## 4. GitHub Actions to Amazon ECR

The application source code is stored in GitHub.

When code is pushed to the repository, GitHub Actions can:

1. Check out the source code.
2. Install application dependencies.
3. Run automated tests.
4. Build the Docker image.
5. Authenticate with AWS.
6. Push the Docker image to Amazon ECR.

The image flow is:

```text
GitHub
   |
   v
GitHub Actions
   |
   | Run Tests
   | Build Docker Image
   v
Amazon ECR
```

---

## 5. Amazon ECR

Amazon Elastic Container Registry (ECR) stores Docker images.

GitHub Actions pushes the Docker image to an ECR repository.

The ECS Task Definition references the Docker image stored in ECR.

The flow is:

```text
Docker Image
     |
     v
Amazon ECR
     |
     v
ECS Task
```

---

## 6. IAM

AWS Identity and Access Management (IAM) controls permissions.

IAM is used to control:

* Permissions for GitHub Actions to push images to ECR.
* Permissions for ECS to access AWS resources.
* Permissions for sending logs to CloudWatch.

A secure approach is to use an IAM Role with GitHub OIDC authentication instead of storing long-term AWS access keys in GitHub.

Permissions should follow the principle of least privilege.

---

## 7. VPC and Networking

The application would run inside an Amazon VPC.

A basic network design could include:

```text
AWS VPC
|
|-- Public Subnets
|      |
|      |-- Application Load Balancer
|
|-- Private Subnets
       |
       |-- ECS Task 1
       |
       |-- ECS Task 2
```

The Application Load Balancer is publicly accessible.

The ECS application tasks can run in private subnets and are not directly exposed to the internet.

---

## 8. Security Groups

AWS Security Groups act as virtual firewalls.

### Application Load Balancer Security Group

Allows public traffic such as:

* HTTP on port `80`
* HTTPS on port `443`

### ECS Application Security Group

Allows application traffic only from the Application Load Balancer on the required application port.

This limits direct access to the application containers.

---

## 9. Application Access

Users access the application through an Application Load Balancer.

The traffic flow is:

```text
User
  |
  v
Internet
  |
  v
Application Load Balancer
  |
  v
ECS Service
  |
  +-----> ECS Task 1
  |
  +-----> ECS Task 2
```

The Load Balancer distributes traffic between healthy application tasks.

The `/health` endpoint can be used for health checks.

---

## 10. CloudWatch Logging

Application and container logs can be sent to Amazon CloudWatch Logs.

The flow is:

```text
Application
     |
     v
Container Logs
     |
     v
CloudWatch Logs
```

CloudWatch can be used to:

* View application logs.
* Monitor errors.
* Monitor ECS resources.
* Troubleshoot application problems.

---

## 11. Basic Security Considerations

The following security practices should be followed:

* Do not commit passwords, AWS access keys, tokens, or private keys to GitHub.
* Use IAM roles and least-privilege permissions.
* Use private subnets for application containers.
* Restrict Security Group rules to required ports.
* Expose the application through a Load Balancer.
* Use HTTPS for production environments.
* Run the Docker container as a non-root user.

---

## Conclusion

The proposed AWS deployment approach uses:

```text
GitHub
   |
   v
GitHub Actions
   |
   v
Docker Image
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

Amazon ECR stores the Docker image, ECS with Fargate runs the application, the Application Load Balancer provides user access, IAM manages permissions, Security Groups control network traffic, and CloudWatch provides logging and monitoring.
