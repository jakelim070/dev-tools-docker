#!/bin/bash
# Generates .htpasswd file for Nginx Basic Auth

# Script is in nginx-custom/scripts/, we want auth in nginx-custom/auth/
SCRIPT_DIR="$(dirname "$0")"
AUTH_DIR="$SCRIPT_DIR/../auth"
mkdir -p "$AUTH_DIR"

USERNAME="admin"
PASSWORD="admin"
PASS_FILE="$AUTH_DIR/htpasswd"

# Check if openssl is available
if command -v openssl &> /dev/null; then
    # Use openssl to generate apr1 (MD5-based) hash
    ENCRYPTED_PASS=$(openssl passwd -apr1 "$PASSWORD")
    echo "${USERNAME}:${ENCRYPTED_PASS}" > "$PASS_FILE"
    echo "Generated $PASS_FILE with user '$USERNAME' using openssl"
elif command -v python3 &> /dev/null; then
    # Fallback to python
    python3 -c "import crypt; print('${USERNAME}:' + crypt.crypt('${PASSWORD}', crypt.mksalt(crypt.METHOD_MD5)))" > "$PASS_FILE"
    echo "Generated $PASS_FILE with user '$USERNAME' using python3"
else
    echo "Error: Neither openssl nor python3 found. Cannot generate password hash."
    exit 1
fi
