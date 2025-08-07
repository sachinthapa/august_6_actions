#!/bin/bash

# Use prime numbers from cached directory
# Usage: ./primes.sh -d <directory>

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

if [ ! -d "$DIRECTORY" ]; then
  echo "Error: Directory $DIRECTORY does not exist"
  exit 1
fi

echo "Using prime numbers from $DIRECTORY"

# Check if prime files exist
if [ ! -f "$DIRECTORY/primes.txt" ]; then
  echo "Error: primes.txt not found in $DIRECTORY"
  exit 1
fi

# Display prime statistics
PRIME_COUNT=$(wc -l < "$DIRECTORY/primes.txt")
LARGEST_PRIME=$(tail -n 1 "$DIRECTORY/primes.txt")
SMALLEST_PRIME=$(head -n 1 "$DIRECTORY/primes.txt")

echo "Prime number statistics:"
echo "  Total primes: $PRIME_COUNT"
echo "  Smallest prime: $SMALLEST_PRIME"
echo "  Largest prime: $LARGEST_PRIME"

# Show first 10 primes
echo "First 10 primes:"
head -n 10 "$DIRECTORY/primes.txt" | tr '\n' ' '
echo

# Show last 10 primes
echo "Last 10 primes:"
tail -n 10 "$DIRECTORY/primes.txt" | tr '\n' ' '
echo

# Calculate sum of all primes (demo computation)
SUM=$(awk '{sum+=$1} END {print sum}' "$DIRECTORY/primes.txt")
echo "Sum of all primes: $SUM"

# Test if specific numbers are prime
echo "Testing if some numbers are in our prime list:"
test_numbers=(17 25 97 100 997)
for num in "${test_numbers[@]}"; do
  if grep -q "^$num$" "$DIRECTORY/primes.txt"; then
    echo "  $num: PRIME ✓"
  else
    echo "  $num: NOT PRIME ✗"
  fi
done

echo "Prime number processing complete!"
