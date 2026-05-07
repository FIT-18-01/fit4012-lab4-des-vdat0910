#!/usr/bin/env bash
set -euo pipefail

g++ -std=c++17 -Wall -Wextra -pedantic des.cpp -o des

base64="0000000100100011010001010110011110001001101010111100110111101111"
suffix="1010101010101010"
plaintext="${base64}${suffix}"
key="0001001100110100010101110111100110011011101111001101111111110001"

ciphertext=$(printf "1\n%s\n%s\n" "$plaintext" "$key" | ./des | tr -d '\r\n')

if [[ $(( ${#ciphertext} % 64 )) -ne 0 ]]; then
  echo "Ciphertext length is not a multiple of 64"
  exit 1
fi

pad_len=$((64 - (${#plaintext} % 64)))
padded="$plaintext"
for ((i=0;i<pad_len;i++)); do
  padded+="0"
done

decrypted=$(printf "2\n%s\n%s\n" "$ciphertext" "$key" | ./des | tr -d '\r\n')

if [[ "$decrypted" != "$padded" ]]; then
  echo "Padding check failed. Expected $padded, got $decrypted"
  exit 1
fi

echo "PASS: multi-block padding"
