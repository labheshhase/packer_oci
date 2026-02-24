#!/bin/bash

echo "Updating system packages..."
sudo apt-get update -y
sudo apt-get upgrade -y

echo "Installing common utilities..."
sudo apt-get install -y curl wget git

echo "Cleaning up..."
sudo apt-get autoremove -y
sudo apt-get clean

echo "Provisioning complete!"
