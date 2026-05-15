#!/bin/bash

# This script downloads to VM and configures GitHub Actions Runner to run on the VM.
# It takes a single argument, which is the token for the runner.

set -e

REPO_URL="https://github.com/kaushikaW/cocodoll"
TOKEN="$1"

apt update -y
apt install -y curl git docker.io

# allow runner user to use docker
VM_USER=$(getent passwd 1000 | cut -d: -f1)
usermod -aG docker $VM_USER

# apply group change without reboot
newgrp docker || true

systemctl enable docker
systemctl start docker


mkdir -p /actions-runner
cd /actions-runner

curl -o runner.tar.gz -L https://github.com/actions/runner/releases/download/v2.334.0/actions-runner-linux-x64-2.334.0.tar.gz

tar xzf runner.tar.gz

./config.sh \
  --url $REPO_URL \
  --token $TOKEN \
  --unattended \
  --replace

./svc.sh install
./svc.sh start