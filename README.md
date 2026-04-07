# AWS Sysadmin Lab / AWS-3Tier-Application

## Overview

This repository provisions and configures a 3-tier AWS application environment using Terraform for infrastructure and Ansible for instance configuration.

The architecture includes:
- VPC with public, private, and database subnets
- Internet Gateway and NAT Gateways
- Application Load Balancer with HTTP/HTTPS listeners
- AWS WAF for web application protection
- Auto Scaling group for web application servers
- RDS PostgreSQL database hosted in private subnets
- EFS file system mounted by web servers
- CloudWatch monitoring, dashboards, alarms, and logs
- AWS Backup and VPC Flow Logs
- Ansible control host for configuring EC2 instances

## Repository Structure

- `terraform/` - AWS infrastructure as code
- `ansible/` - Ansible inventory, playbooks, and roles for server configuration
- `scripts/` - helper scripts for key generation, credential switching, and cleanup
- `pre-deploy/` - supporting roles and tasks for pre-deployment operations
- `env_vars.sh` - local environment variables for deployment (should not be committed)

## Terraform Components

The Terraform code provisions the following major resources:
- `vpc.tf`, `subnets.tf`, `routes.tf` - VPC networking and route tables
- `gateways.tf` - Internet Gateway and NAT Gateways
- `security_groups.tf` - security groups for ALB, EC2, RDS, EFS, bastion, and control host
- `ec2.tf` and `asg.tf` - EC2 web servers, bastion host, and auto scaling configuration
- `alb.tf` - Application Load Balancer, target groups, and listeners
- `rds.tf` - PostgreSQL RDS instance and Secrets Manager credentials
- `efs.tf` - EFS file system and mount targets
- `iam.tf` - IAM roles, instance profiles, and permissions for EC2 instances
- `ssm.tf` - SSM parameters for shareable environment values
- `waf.tf` - AWS WAF Web ACL and logging configuration
- `monitoring.tf` - CloudWatch dashboard, alarms, SNS notifications, and log groups
- `backup.tf` - AWS Backup vault, plan, and selection
- `flow_logs.tf` - VPC Flow Logs bucket and IAM policy
- `acm.tf` - ACM certificate for SSL/TLS termination
- `keypair.tf` - key pair generation for EC2 access

## Ansible Configuration

The Ansible setup uses dynamic inventory and applies a set of roles to all provisioned web hosts.

- `ansible/inventory/aws_ec2.yml` - dynamic AWS EC2 inventory plugin filtering by instance tags and state
- `ansible/site.yml` - execution entry point that applies the roles:
  - `common` - base system configuration and shared setup
  - `efs` - mount and configure EFS on web servers
  - `httpd` - install and configure Apache HTTP Server
  - `app` - deploy the application code and templates
  - `cloudwatch` - install and configure CloudWatch agent

## Deployment Flow

1. Set AWS credentials and environment variables in `env_vars.sh`.
2. Run Terraform from `terraform/`:
   - `terraform init`
   - `terraform plan`
   - `terraform apply`
3. Use the Ansible control host or local Ansible environment to run `ansible/site.yml` against the EC2 inventory.
4. Verify the load balancer, application servers, database connectivity, and monitoring tools.

## Notes

- Sensitive files such as `terraform/terraform.tfvars`, certificate files in `terraform/data/certs/`, and `env_vars.sh` are local-only and should not be committed.
- The AWS region used by the inventory plugin is `ca-central-1`.
- The dynamic inventory selects running EC2 instances tagged as `web-asg-instance`.

## What This Builds

This lab builds a secure, scalable AWS application stack with automated provisioning and configuration, suitable for learning or validating AWS infrastructure and DevOps workflows.
