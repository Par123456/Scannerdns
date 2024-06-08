#!/bin/bash

# Function to generate random IPv4 address
generate_ipv4() {
  echo "$((RANDOM % 256)).$((RANDOM % 256)).$((RANDOM % 256)).$((RANDOM % 256))"
}

# Function to generate random IPv6 address within a given subnet
generate_ipv6() {
  local subnet=$1
  rand_suffix=$(openssl rand -hex 8 | sed 's/\(..\)/\1:/g' | sed 's/:$//')
  echo "$subnet$rand_suffix"
}

# Check if the user has provided a subnet and the type (IPv4 or IPv6)
if [ -z "$1" ] || [ -z "$2" ]; then
  echo "Usage: $0 <type> <subnet>"
  echo "type: ipv4 or ipv6"
  exit 1
fi

TYPE=$1
SUBNET=$2

addresses=()

# Generate addresses based on type
if [ "$TYPE" == "ipv4" ]; then
  echo "Generating random IPv4 addresses...
https://t.me/No1API7"
  for i in $(seq 1 10); do
    addresses+=("$(generate_ipv4)")
  done
elif [ "$TYPE" == "ipv6" ]; then
  echo "Generating random IPv6 addresses within the subnet $SUBNET..."
  for i in $(seq 1 10); do
    addresses+=("$(generate_ipv6 $SUBNET)")
  done
else
  echo "Invalid type. Please use ipv4 or ipv6."
  exit 1
fi

# Scan the generated addresses using nmap
echo "Scanning the generated addresses..."
for addr in "${addresses[@]}"; do
  echo "Scanning $addr..."
  if [ "$TYPE" == "ipv4" ]; then
    nmap -4 -sP "$addr"
  elif [ "$TYPE" == "ipv6" ]; then
    nmap -6 -sP "$addr"
  fi
done

echo "Scan complete."
