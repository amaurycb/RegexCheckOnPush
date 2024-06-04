#!/bin/bash

# Define the patterns to search for
pattern=$(echo "${INPUT_PATTERN}")

#Define if deep check is needed
deep=$(echo "${INPUT_DEEP}")

# Array to store the files that match the pattern
matching_files=()

  # Get a list of all files in the repository
if [ $deep -eq 0 ]; then
  # Obtener el hash del último commit
  commit_hash=$(git rev-parse HEAD)
  # Listar los archivos modificados en el último commit
  git diff-tree --no-commit-id --name-only -r "$commit_hash"
else
  changed_files=$(git ls-files)
fi



# Loop through each changed file
for file in $changed_files; do
  echo "Checking file: $file"
  
  # Loop through each pattern  
    # Check if the pattern exists in the file
    if grep -Eq "$pattern" "$file"; then
      echo "Pattern '$pattern' found in file '$file'"
      pattern_found=1
      # Add the file to the array of matching files
      matching_files+=("$file")
    fi  
done

# Exit with a non-zero status if any pattern is found
if [ ${#matching_files[@]} -ne 0 ]; then
  echo "Pattern(s) found, failing the check."
  exit 1
else
  echo "No patterns found."
  exit 0
fi

