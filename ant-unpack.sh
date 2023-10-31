#!/bin/bash

# Check if the input file is provided
if [ "$#" -lt 1 ]; then
    echo "Usage: $0 <path_to_ear_or_war_file> [<destination_folder>]"
    exit 1
fi

input_file="$1"
destination_folder="${2:-.}"  # Use current folder if destination folder is not provided

mkdir -p "$destination_folder"
echo "<project/>" > $destination_folder/build.xml

if [[ "$input_file" == *".ear" ]]; then
    unzip -o "$input_file" "*.war" "*.jar" -d "$destination_folder"
    
    for warFile in $(find $destination_folder -name '*.war'); do
        unzip -o "$warFile" "*.jar" -d "$destination_folder"
    done
elif [[ "$input_file" == *".war" ]]; then
    unzip -o "$input_file" "*.jar" -d "$destination_folder"
else
    echo "Invalid input file. Please provide an EAR or WAR file."
    exit 1
fi

jar_count=$(find "$destination_folder" -type f -name "*.jar" | wc -l)
if [ "$jar_count" -eq 0 ]; then
    echo "Error: No JAR files were found or extracted from the given file."
    exit 1
fi

find "$destination_folder" -type f -name "*.war" -delete
echo "Total JAR files extracted in folder \"$destination_folder\": $jar_count"
