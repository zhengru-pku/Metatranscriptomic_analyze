#!/bin/bash

for i in *.fa 
do
input_file="${i}"
output_file="${i}_cleaned.fasta"
sed 's/^>\([^f]*\).*/>\1/' "$input_file" > "$output_file"
done

for file in *.fasta; do
  [ -e "$file" ] || continue
  tmpfile="${file}.tmp"
  declare -A seq_count  

  > "$tmpfile"

  while IFS= read -r line; do
    if echo "$line" | grep -q '^>'; then
      seq_name=$(echo "$line" | sed 's/^>//')
      count=${seq_count[$seq_name]}
      if [ -n "$count" ]; then
        count=$((count + 1))
        seq_count[$seq_name]=$count
        line=">${seq_name}_$count"
      else
        seq_count[$seq_name]=1
        line=">${seq_name}_1"
      fi
    fi
    echo "$line" >> "$tmpfile"
  done < "$file"

  mv "$tmpfile" "$file"
done