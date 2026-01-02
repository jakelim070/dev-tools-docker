#!/bin/bash
set -e

echo "Starting setup..."

# 1. Generate Certificates
echo "Generating Certificates..."
chmod +x nginx-custom/scripts/generate_certs.sh
./nginx-custom/scripts/generate_certs.sh

# 2. Generate Authentication
echo "Generating Authentication..."
chmod +x nginx-custom/scripts/generate_auth.sh
./nginx-custom/scripts/generate_auth.sh

echo "Setup complete. Certificates and Auth file generated."
echo "You can now run 'docker-compose up -d --build'"
