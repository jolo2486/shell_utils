#!/bin/bash

if [ ! -d "$1" ]; then
    mkdir -p $1
    echo "Directory $1 did not exist; created it!"
fi

# create main .gitignore
echo -e "*.com\n*.class\n*.o\n*.so\n*.sublime*\n\n# Folders #\n###################\nsandbox/\n.ipynb_checkpoints/\n__pycache__/" > "$1/.gitignore"

# create subdirectories
for dir in "${@:3}"; do
    mkdir -p "$1/$dir"
    
    # .gitignore file in each subdirectory
    echo -e "*\n!.gitignore" > "$1/$dir/.gitignore"
done

# environment.yml
echo -e "name: $2\nchannels:\n  - conda-forge\n  - defaults\ndependencies:\n  - python\n  - pip\n  - numpy\n  - matplotlib\n  - seaborn\n  - jupyter\n  - pandas\n  - cython\n  - pip:\n    - cmake\n    - sci_analysis" > "$1/environment.yml"

echo "Project initialized in $1 with subdirectories: ${@:3}"
