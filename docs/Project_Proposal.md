## Project Proposal
Internal Container Management Platform Based on Portainer

## 1. Project Idea
The idea behind this project is to build an internal container management platform that provides technical teams with a simple and centralized way to manage Docker containers.
Instead of relying only on command-line operations to manage containers, the platform uses Portainer Community Edition (CE) to provide a web-based interface for viewing and managing containers, logs, networks, volumes, and other Docker resources.
The platform is hosted on Microsoft Azure and combines cloud infrastructure, containerization, Infrastructure as Code, and automation in one practical solution.

## 2. Why We Chose This Topic
We chose this topic because containerization and cloud computing are widely used in modern application environments, and managing containerized workloads is an important operational task for technical teams.
The project also gave us the opportunity to apply several cloud computing concepts in one solution, including:
- Microsoft Azure infrastructure
- Infrastructure as Code using Terraform
- Docker and Docker Compose
- Linux server administration
- Bash automation
- Network security
- Container management using Portainer
This made the project a practical way to connect the different skills covered during the Cloud Computing Bootcamp.

## 3. How We Solved It
We designed and deployed the platform on an Ubuntu Linux Virtual Machine in Microsoft Azure.
The Azure infrastructure is defined using Terraform, including the virtual network, subnet, Network Security Group, Public IP, network interface, and virtual machine.
Docker is used as the container runtime, while Docker Compose defines and deploys the container stack. Portainer CE provides the centralized management interface, and an Nginx container is included as a test workload.
We also developed Bash scripts to automate Docker installation, platform deployment, service management, log review, and health checks. A persistent Docker volume is used to retain Portainer data.

## 4. General Project Overview
The final solution demonstrates how an internal technical team can deploy and operate a simple container management platform in the cloud.
The project combines:
Azure → Terraform → Linux VM → Docker → Docker Compose → Portainer → Automation
Through Portainer, users can centrally manage Docker resources, while Terraform and Bash automation make the infrastructure and deployment processes more repeatable and easier to manage.
The project is designed as a single-node implementation, with future possibilities such as private connectivity, centralized monitoring, backup and recovery, CI/CD, multiple Docker hosts, and Kubernetes integration.
