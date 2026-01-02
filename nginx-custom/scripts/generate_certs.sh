#!/bin/bash

# Ensure we write to ../certs regardless of invocation path
# The script is in nginx-custom/scripts/, we want certs in nginx-custom/certs/
SCRIPT_DIR="$(dirname "$0")"
# Go up one level from scripts to nginx-custom, then to certs
CERTS_DIR="$SCRIPT_DIR/../certs"

mkdir -p "$CERTS_DIR"

# Generate self-signed certificate
openssl req -x509 -nodes -days 365 -newkey rsa:2048 \
    -keyout "$CERTS_DIR/nginx.key" \
    -out "$CERTS_DIR/nginx.crt" \
    -subj "/C=US/ST=State/L=City/O=Organization/CN=localhost"

echo "Certificates generated in $CERTS_DIR/"
