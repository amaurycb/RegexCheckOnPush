#!/bin/bash

# Define the patterns to search for
#patterns=$(echo "${INPUT_PATTERNS}"
pattern="\bdelete\b"

#Define if deep check is needed
#deep=$(echo "${INPUT_DEEP}")
deep=1
  # Get a list of all files in the repository
if [ $deep -eq 0 ]; then
  # Obtener el hash del último commit
  commit_hash=$(git rev-parse HEAD)
  # Listar los archivos modificados en el último commit
  git diff-tree --no-commit-id --name-only -r "$commit_hash"
else
  changed_files=$(git ls-files)
fi

# Flag to indicate if any pattern is found
pattern_found=0

# Loop through each changed file
for file in $changed_files; do
  echo "Checking file: $file"
  
  # Loop through each pattern  
    # Check if the pattern exists in the file
    if grep -Eq "$pattern" "$file"; then
      echo "Pattern '$pattern' found in file '$file'"
      pattern_found=1
    fi  
done

# Exit with a non-zero status if any pattern is found
if [ $pattern_found -ne 0 ]; then
  echo "Pattern(s) found, failing the check."
  exit 1
else
  echo "No patterns found."
  exit 0
fi

