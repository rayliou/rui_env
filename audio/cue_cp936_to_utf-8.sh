#!/bin/bash
dir="${1:-.}"

find "$dir" -name '*.cue' | while read -r file; do
    base="${file%.cue}"
    iconv -f cp936 -t utf-8 "$file" > "$base"
    mv -vf "$base" "$file"
    echo "Processed: $file"
done

# run 'mediahuman audio converter.app'
