#!/bin/bash

# Check if the user has provided a subnet to scan
if [ -z "$1" ]; then
  echo "Usage: $0 <IPv6-subnet>"
  exit 1
fi

SUBNET=$1

# Generate a list of random IPv6 addresses within the given subnet
echo "Generating random IPv6 addresses within the subnet $SUBNET..."
addresses=()
for i in $(seq 1 10); do
  rand_suffix=$(openssl rand -hex 8 | sed 's/\(..\)/\1:/g' | sed 's/:$//')
  addresses+=("$SUBNET$rand_suffix")
done

# Scan the generated addresses using nmap
echo "Scanning the generated addresses..."
for addr in "${addresses[@]}"; do
  echo "Scanning $addr..."
  nmap -6 -sP "$addr"
done

echo "Scan complete."
