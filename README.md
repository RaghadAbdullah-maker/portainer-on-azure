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

## Current status

The Terraform configuration for the network and VM has been added. `terraform init -backend=false` and `terraform validate` completed successfully. Deploying the VM and installing Portainer are the next steps.

## Team workflow

Each team member works on a separate Git branch and opens a pull request before merging changes into `main`.

Do not upload `terraform.tfvars`, private SSH keys, or passwords to GitHub.