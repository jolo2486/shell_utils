#!/bin/bash

# Initialize variables
git_init=false
commit_message="Initial commit"

# Process options
while [ $# -gt 0 ]; do
    case "$1" in
        -g|--git)
            git_init=true
            ;;
        -m|--message)
            shift
            commit_message="$1"
            ;;
        *)
            break
            ;;
    esac
    shift
done

# The first non-option argument is the project directory
project_dir=$1
shift

# Check if directory exists
if [ ! -d "$project_dir" ]; then
    mkdir -p "$project_dir"
    echo "Directory $project_dir did not exist; created it!"
fi

# create main .gitignore
echo -e "*.com\n*.class\n*.o\n*.so\n*.sublime*\n\n# Folders #\n###################\nsandbox/\n.ipynb_checkpoints/\n__pycache__/" > "$project_dir/.gitignore"

# create subdirectories
for dir in "$@"; do
    mkdir -p "$project_dir/$dir"
    
    # .gitignore file in each subdirectory
    echo -e "*\n!.gitignore" > "$project_dir/$dir/.gitignore"
done

# environment.yml
echo -e "name: $project_dir\nchannels:\n  - conda-forge\n  - defaults\ndependencies:\n  - python\n  - pip\n  - numpy\n  - matplotlib\n  - seaborn\n  - jupyter\n  - pandas\n  - cython\n  - pip:\n    - cmake\n    - sci_analysis" > "$project_dir/environment.yml"

# Git initialization
if $git_init; then
    cd "$project_dir"
    git init -b main
    git add .
    git commit -m "$commit_message"
fi

echo "Project initialized in $project_dir with subdirectories: $@"
