#!/bin/bash

# This script downloads to VM and configures GitHub Actions Runner to run on the VM.
# It takes a single argument, which is the token for the runner.

TOKEN="$1"
REPO_URL="https://github.com/kaushikaW/cocodoll"

apt update -y
apt install -y curl git docker.io

systemctl enable docker
systemctl start docker

usermod -aG docker azureadmin

# run everything as azureadmin
su - azureadmin <<EOF

mkdir -p /home/azureadmin/actions-runner
cd /home/azureadmin/actions-runner

curl -o runner.tar.gz -L https://github.com/actions/runner/releases/download/v2.334.0/actions-runner-linux-x64-2.334.0.tar.gz

tar xzf runner.tar.gz

./config.sh \
  --url $REPO_URL \
  --token $TOKEN \
  --unattended \
  --replace

./svc.sh install
./svc.sh start

EOF