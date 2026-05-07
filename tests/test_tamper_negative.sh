#!/usr/bin/env bash
set -euo pipefail

g++ -std=c++17 -Wall -Wextra -pedantic des.cpp -o des

plaintext="0000000100100011010001010110011110001001101010111100110111101111"
key="0001001100110100010101110111100110011011101111001101111111110001"

ciphertext=$(printf "1\n%s\n%s\n" "$plaintext" "$key" | ./des | tr -d '\r\n')

flip_bit() {
  local value="$1"
  local index="$2"
  local bit="${value:$index:1}"
  local flipped="0"
  if [[ "$bit" == "0" ]]; then
    flipped="1"
  fi
  echo "${value:0:$index}${flipped}${value:$((index+1))}"
}

tampered=$(flip_bit "$ciphertext" 5)
decrypted=$(printf "2\n%s\n%s\n" "$tampered" "$key" | ./des | tr -d '\r\n')

if [[ "$decrypted" == "$plaintext" ]]; then
  echo "Tamper negative test failed: plaintext unexpectedly recovered"
  exit 1
fi

echo "PASS: tamper negative"
