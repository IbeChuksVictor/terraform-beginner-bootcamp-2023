#!/usr/bin/env bash

cd /workspace

FILENAME="/workspace/awscliv2.zip"
DIRECTORY_NAME="/workspace/aws"

if [ -f "$FILENAME" ]; then
    rm -f "$FILENAME"
fi

if [ -d "$DIRECTORY_NAME" ]; then
    rm -rf "$DIRECTORY_NAME"
fi

curl -o "awscliv2.zip" "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip"
unzip awscliv2.zip
sudo ./aws/install

aws --version

aws sts get-caller-identity
