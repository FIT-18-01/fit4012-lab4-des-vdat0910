#!/usr/bin/env bash
set -euo pipefail

g++ -std=c++17 -Wall -Wextra -pedantic des.cpp -o des

plaintext="0000000100100011010001010110011110001001101010111100110111101111"
key="0001001100110100010101110111100110011011101111001101111111110001"
expected="1000010111101000000100110101010000001111000010101011010000000101"

output=$(printf "1\n%s\n%s\n" "$plaintext" "$key" | ./des | tr -d '\r\n')

if [[ "$output" != "$expected" ]]; then
  echo "Expected ciphertext $expected, got $output"
  exit 1
fi

echo "PASS: DES sample vector"
