#!/usr/bin/env bash
set -euo pipefail

g++ -std=c++17 -Wall -Wextra -pedantic des.cpp -o des

plaintext="0000000100100011010001010110011110001001101010111100110111101111"
key="0001001100110100010101110111100110011011101111001101111111110001"

ciphertext=$(printf "1\n%s\n%s\n" "$plaintext" "$key" | ./des | tr -d '\r\n')
decrypted=$(printf "2\n%s\n%s\n" "$ciphertext" "$key" | ./des | tr -d '\r\n')

if [[ "$decrypted" != "$plaintext" ]]; then
  echo "Round-trip failed. Expected $plaintext, got $decrypted"
  exit 1
fi

echo "PASS: DES round-trip"
