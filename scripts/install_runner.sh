#!/bin/bash

TOKEN="$1"
REPO="https://github.com/kaushikaW/cocodoll"

sudo apt update -y
sudo apt install -y curl git docker.io

sudo systemctl enable docker
sudo systemctl start docker

sudo usermod -aG docker azureadmin

mkdir -p /home/azureadmin/actions-runner
cd /home/azureadmin/actions-runner

curl -o runner.tar.gz -L \
https://github.com/actions/runner/releases/download/v2.334.0/actions-runner-linux-x64-2.334.0.tar.gz

tar xzf runner.tar.gz

./config.sh \
  --url $REPO \
  --token $TOKEN \
  --unattended \
  --replace

./run.sh