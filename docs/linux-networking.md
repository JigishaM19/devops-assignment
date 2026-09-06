# Linux and Networking Documentation

## Overview

This document describes basic Linux commands and networking concepts that can be used to monitor, operate, and troubleshoot the DevOps Assignment application.

The application is a Python web application that runs on port `5000` and can be deployed locally, using Docker, and using Kubernetes.

---

## 1. CPU, Memory, and Disk Checks

### CPU and Running Processes

```bash
top
```

The `top` command displays running processes and system resource usage, including CPU and memory usage.

### Memory

```bash
free -h
```

This command displays total, used, and available memory in a human-readable format.

### Disk

```bash
df -h
```

This command displays disk usage and available disk space.

---

## 2. Running Processes

To view running processes:

```bash
ps aux
```

To search for a specific process, for example Python:

```bash
ps aux | grep python
```

These commands can help determine whether the application is running.

---

## 3. Listening Ports

To check listening ports and associated processes:

```bash
ss -tulpn
```

This is useful for checking whether the application is listening on the expected port, such as port `5000`.

---

## 4. Network Interfaces and Routes

To view network interfaces and IP addresses:

```bash
ip addr
```

To view routing information:

```bash
ip route
```

These commands help identify network interfaces, IP addresses, default gateways, and network routes.

---

## 5. Application Logs

### Docker Logs

To view logs from a Docker container:

```bash
docker logs <container-id>
```

To continuously follow logs:

```bash
docker logs -f <container-id>
```

### Kubernetes Logs

To view logs from a Kubernetes Pod:

```bash
kubectl logs <pod-name>
```

To continuously follow the logs:

```bash
kubectl logs -f <pod-name>
```

Logs are useful for troubleshooting application errors and deployment problems.

---

## 6. 127.0.0.1 vs 0.0.0.0

### 127.0.0.1

`127.0.0.1` is the loopback address. An application listening on this address is accessible only from the same machine.

### 0.0.0.0

`0.0.0.0` means the application listens on all available network interfaces.

For Docker and Kubernetes environments, the application commonly listens on `0.0.0.0` so it can receive network traffic from outside the application process.

---

## 7. Public IP vs Private IP

A **public IP address** can be accessed from the internet, depending on firewall and security rules.

A **private IP address** is used for communication inside a private network.

In AWS, an application can run using private IP addresses inside a VPC while users access it through a public Application Load Balancer.

---

## 8. Host Port vs Container Port

Docker containers have their own network environment.

Example:

```bash
docker run -p 8080:5000 devops-assignment
```

This means:

```text
Host Port 8080
       |
       v
Container Port 5000
```

Users access the application through port `8080` on the host, and Docker forwards the traffic to port `5000` inside the container.

---

## 9. Basic TCP and HTTP Concepts

### TCP

TCP (Transmission Control Protocol) provides reliable communication between systems.

The application listens for network connections on a TCP port.

### HTTP

HTTP (Hypertext Transfer Protocol) is used for communication between a client and a web application.

Example flow:

```text
Client
   |
   | HTTP Request
   v
Application
   |
   | HTTP Response
   v
Client
```

This project provides the following HTTP endpoints:

```text
GET /
GET /health
```

---

## 10. AWS Security Groups

AWS Security Groups act as virtual firewalls.

They control inbound and outbound network traffic.

For example:

* An Application Load Balancer can allow HTTP traffic on port `80`.
* HTTPS traffic can use port `443`.
* Application containers should only allow required traffic from trusted sources, such as the Application Load Balancer.

Security Groups should follow the principle of least privilege by allowing only necessary ports and traffic.

---

## Conclusion

These Linux commands and networking concepts are useful for monitoring, troubleshooting, and operating the application in local, Docker, Kubernetes, and AWS environments.
