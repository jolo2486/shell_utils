#!/bin/bash

# Check if a directory path was provided
if [ $# -eq 0 ]
then
    echo "Please provide a directory path"
    exit 1
fi

# Get the directory path
dir_path=$1

# Create/Open the markdown file
markdown_file="folder_structure.md"
echo -e ".\n├── ...\n" > $markdown_file

# Function to iterate through subdirectories
iterate_directory() {
    local parent_dir=$1
    local prefix=$2

    for dir in $(find $parent_dir -maxdepth 1 -mindepth 1 -type d)
    do
        # Extract the base name of the directory
        dir_name=$(basename $dir)

        # Write the directory name to the markdown file with a placeholder comment
        echo -e "${prefix}${dir_name}                    # comment" >> $markdown_file

        # Iterate through its immediate subdirectories if it's not a subdirectory of a subdirectory
        if [ $prefix == "├── " ]
        then
            iterate_directory $dir "│   ├── "
        fi
    done
}

# Iterate through the immediate subdirectories
iterate_directory $dir_path "├── "

# Write the closing line to the markdown file
echo -e "└── ...\n" >> $markdown_file

echo "Markdown file created: ${markdown_file}"
