#!/bin/bash

TOKEN="$1"
REPO_URL="https://github.com/kaushikaW/cocodoll"

# Update system
sudo apt update -y

# install docker
sudo apt update -y
sudo apt install -y docker.io

# Enable and start Docker service
sudo systemctl enable docker
sudo systemctl start docker

# Add the current user to the docker group to run Docker commands without sudo
sudo usermod -aG docker azureadmin

# Required dependencies
sudo apt install -y curl tar git libicu-dev

# Create user folder
mkdir -p /home/azureadmin/actions-runner
cd /home/azureadmin/actions-runner

# Download Linux runner (IMPORTANT FIX)
curl -o actions-runner.tar.gz -L \
https://github.com/actions/runner/releases/download/v2.334.0/actions-runner-linux-x64-2.334.0.tar.gz

# Extract
tar xzf actions-runner.tar.gz

# Configure runner
./config.sh \
  --url $REPO_URL \
  --token $TOKEN \
  --unattended \
  --replace

# Install service
sudo ./svc.sh install
sudo ./svc.sh start