# Portainer on Azure

This team project uses Terraform to prepare an Azure Linux VM for running Portainer with Docker.

## Architecture

Administrator → Public IP → Azure Linux VM → Docker → Portainer

The VM connects to a virtual network and subnet. Network security rules allow SSH (port 22) and Portainer HTTPS (port 9443) only from the administrator IP addresses configured in Terraform.

## Project files

- `terraform/` — Azure infrastructure configuration
- `docker/` — Portainer Docker Compose file (planned)
- `scripts/` — Docker installation script (planned)
- `docs/` — Architecture and screenshots (planned)
- `presentation/` — Project slides (planned)

## Repository Structure
portainer-on-azure/
├── terraform/                   
│   ├── providers.tf
│   ├── main.tf
│   ├── variables.tf
│   ├── outputs.tf
│   ├── terraform.tfvars.example
│   └── .terraform.lock.hcl
├── docker/
│   └── docker-compose.yml        
├── scripts/
│   └── install-docker.sh         # Docker installation script for the VM
├── docs/
│   ├── PROJECT_PLAN.md
│   ├── ARCHITECTURE.md
│   ├── architecture.png         
│   ├── implementation-guide.md   
│   └── screenshots/              
├── presentation/
│   └── portainer-on-azure.pptx   # Project presentation
├── .gitignore
└── README.md


## Prerequisites
Terraform >= 1.x
Azure CLI (az login before running Terraform)
An Azure subscription with permissions to create resource groups, networking, and VMs
An SSH key pair per team member who needs VM access

## Current status

The Terraform configuration for the network and VM has been added. `terraform init -backend=false` and `terraform validate` completed successfully. Deploying the VM and installing Portainer are the next steps.

## Team workflow

Each team member works on a separate Git branch and opens a pull request before merging changes into `main`.

Do not upload `terraform.tfvars`, private SSH keys, or passwords to GitHub.