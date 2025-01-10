#!/bin/bash

# Original hash from /etc/shadow
stored_hash='$6$saltsalt123$MM5c82.QkqEIgmbW8687z9fUV39SNqLj7AiNMs3iVTtyusA/3msq5Q5AdhgiCyxqg3m7U0GiGj/fnND5arLnT/'

# Password to test
test_password="password"

# Extract salt from the stored hash
salt=$(echo "$stored_hash" | cut -d'$' -f3)

# Generate hash for the test password
generated_hash=$(openssl passwd -6 -salt "$salt" "$test_password")

# Compare generated hash with stored hash
if [ "$generated_hash" == "$stored_hash" ]; then
  echo "Password matches!"
else
  echo "Password does not match."
fi
