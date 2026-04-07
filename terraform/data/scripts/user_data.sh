#!/bin/bash
set -e
exec > /var/log/user-data.log 2>&1

echo "=== Bootstrap at $(date) ==="

sleep 10

# Just install SSM and Python — Ansible handles everything else
sudo yum update -y
sudo yum install -y python3 amazon-ssm-agent

sudo systemctl enable amazon-ssm-agent
sudo systemctl start amazon-ssm-agent

echo "=== Bootstrap done — waiting for Ansible ==="
