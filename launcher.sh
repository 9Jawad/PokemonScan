#!/bin/bash

# * paug0002
# * jche0027
# * rrab0007

# ---------------------------------[Exécute les makes]-------------------------
#cd img-dist/
#make

#cd ..
#make


# ---------------------------------------[Main]------------------------------------

# Check if there are no command-line arguments provided
if [ $# -eq 0 ]; then
    echo "You need to give the option (-a or -i) and the argument(s) that you want. For example: './launcher -i image_file'. "
    exit 1
fi

# Check if the option is automatic (-a or -automatic)
if [ "$1" = "-a" ] || [ "$1" = "--automatic" ]; then
    # Check if there are less than 2 arguments (insufficient for automatic mode)
    if [ $# -lt 2 ]; then
        echo "You need to give the path of an image."
        exit 1
    # Check if there are exactly 2 arguments
    elif [ $# -eq 2 ]; then
        # Execute list-file.sh with the default image directory and send the result to img-search
        database_path=$(./list-file ./img/)
        ./img-search "$2" "$database_path"
    else
        # Execute list-file.sh with the specified image directory and send the result to img-search
        database_path=$(./list-file "$3")
       ./img-search "$2" "$database_path"
    fi

# Check if the option is interactive (-i or -interactive)
elif [ "$1" = "-i" ] || [ "$1" = "--interactive" ]; then
    # Check if database_path is specified, otherwise set it to an empty string
    database_path=""
    if [ $# -eq 4 ]; then
        database_path="$3"
        shift 3  # Shift the positional parameters to skip the processed arguments
    fi
    # Prompt the user for image input
    echo "Enter image paths like '1.bmp\n2.bmp\n3.bmp\n4.bmp' (press Enter when finished):"
    # Read the input and store it in full_paths
    IFS= read -r -d $'\n' full_paths

    # Replace explicit "\n" with actual newline characters
    full_paths=$(printf "%b" "$full_paths")

    ./img-search "$2" "$database_path$full_paths"

# If the provided option is neither automatic nor interactive
else
    echo "Error input, option not recognized"
fi
