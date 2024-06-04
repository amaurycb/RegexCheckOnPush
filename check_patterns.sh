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
  
  # Loop through each pattern  
    # Check if the pattern exists in the file
    if grep -Eqi "$pattern" "$file"; then
      # Add the file to the array of matching files
      matching_files+=("$file")
    fi  
done

# Exit with a non-zero status if any pattern is found
if [ ${#matching_files[@]} -ne 0 ]; then

  json_array='['

  for elemento in "${matching_files[@]}"; do
    # Escapamos comillas dobles y barras invertidas
    elemento_escapado=${elemento//\\/\\\\}  # Escapa barras invertidas
    elemento_escapado=${elemento_escapado//\"/\\\"} # Escapa comillas dobles

    json_array+="\"$elemento_escapado\","
  done

  json_array=${json_array%,}  # Elimina la última coma sobrante
  json_array+=']'

  echo "$json_array"
  
else
  echo "No patterns found."
  exit 0
fi

