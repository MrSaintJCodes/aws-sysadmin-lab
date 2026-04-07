#!/bin/bash
set -e
exec > /var/log/user-data.log 2>&1

echo "=== Starting user_data at $(date) ==="

sleep 10

echo "=== Installing httpd, NFS utils, Python ==="
sudo yum update -y
sudo yum install -y httpd amazon-efs-utils python3 python3-pip
sudo pip3 install psycopg2-binary
sudo amazon-linux-extras install ansible2 -y




