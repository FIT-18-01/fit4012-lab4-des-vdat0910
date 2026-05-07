#!/usr/bin/env bash
set -euo pipefail

g++ -std=c++17 -Wall -Wextra -pedantic des.cpp -o des

plaintext="0000000100100011010001010110011110001001101010111100110111101111"
key="0001001100110100010101110111100110011011101111001101111111110001"
wrong_key="1111001100110100010101110111100110011011101111001101111111110001"

ciphertext=$(printf "1\n%s\n%s\n" "$plaintext" "$key" | ./des | tr -d '\r\n')
decrypted=$(printf "2\n%s\n%s\n" "$ciphertext" "$wrong_key" | ./des | tr -d '\r\n')

if [[ "$decrypted" == "$plaintext" ]]; then
  echo "Wrong key negative test failed: plaintext unexpectedly recovered"
  exit 1
fi

echo "PASS: wrong key negative"
