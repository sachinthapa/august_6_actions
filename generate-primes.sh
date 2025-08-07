#!/bin/bash

# Generate prime numbers and save to directory
# Usage: ./generate-primes.sh -d <directory>

DIRECTORY=""

while getopts "d:" opt; do
  case $opt in
    d)
      DIRECTORY="$OPTARG"
      ;;
    \?)
      echo "Invalid option: -$OPTARG" >&2
      exit 1
      ;;
  esac
done

if [ -z "$DIRECTORY" ]; then
  echo "Usage: $0 -d <directory>"
  exit 1
fi

# Create directory if it doesn't exist
mkdir -p "$DIRECTORY"

echo "Generating prime numbers..."

# Generate first 1000 prime numbers using sieve of eratosthenes
python3 -c "
import os
import sys

def sieve_of_eratosthenes(limit):
    sieve = [True] * (limit + 1)
    sieve[0] = sieve[1] = False
    
    for i in range(2, int(limit**0.5) + 1):
        if sieve[i]:
            for j in range(i*i, limit + 1, i):
                sieve[j] = False
    
    return [i for i in range(2, limit + 1) if sieve[i]]

# Generate primes up to 10000 to get first 1000 primes
primes = sieve_of_eratosthenes(10000)[:1000]

# Save to files
directory = '$DIRECTORY'
with open(os.path.join(directory, 'primes.txt'), 'w') as f:
    for prime in primes:
        f.write(f'{prime}\n')

print(f'Generated {len(primes)} prime numbers')
print(f'Saved to {directory}/primes.txt')
"

echo "Prime number generation complete!"
