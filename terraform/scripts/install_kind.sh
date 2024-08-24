#!/bin/bash

# Install kubectl
curl -LO "https://storage.googleapis.com/kubernetes-release/release/$(curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt)/bin/linux/amd64/kubectl"
chmod +x ./kubectl
sudo mv ./kubectl /usr/local/bin/kubectl

# Install Kind
curl -Lo ./kind "https://kind.sigs.k8s.io/dl/$(curl -s https://api.github.com/repos/kubernetes-sigs/kind/releases/latest | grep -oP '(?<=tag_name": ")[^"]+')/kind-linux-amd64"
chmod +x ./kind
sudo mv ./kind /usr/local/bin/kind

# Create a Kind cluster
kind create cluster