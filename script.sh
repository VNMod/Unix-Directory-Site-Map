#! /bin/bash

# ECE3524 - Project 1: Intro to Unix
# By Varun Nimish Modak

# Task: to write a shell script that performs a directory tree traveral and generates a site map into an HTML doc

# Special Notes:
# The directories in the HTML document are emboldened as an added feature to differentiate between a directory and file

# Error Handling for Excess Arguments
if (($# != 2))
then
   echo 'Error due to inaccurate number of arguments. Only 2 allowed (excluding the root directory name).'
   exit 1
fi

# This is essential as the given rootname can be in any subdirectory within the current directory's tree
rootpath="$(find . -type d -name "${1##*/}")" # finding the path of the given

# echo "$rootpath" # Debugging purposes

# 2 Arguments: Root of directory tree, output filename
filename="${0##*/}" # name of this script file -- 0th argument
rootname="${rootpath}" # First arg is the root of the directory tree
outfile="${2##*/}" # Second arg is output filename

# Make this script an executable for the user
chmod +x "$filename"

# *** IMPORTANT FOR TARGET FILE CREATION and CLEARING OLD CONTENT IN OLD FILES ***
# Create the target (output) HTML file if it doesn't already exist
if [ ! -f $outfile ]; then
    touch $outfile
else # if it does exist, remove the previous version and create a new version of the output file
    chmod +rwx $outfile
    rm $outfile
    touch $outfile
fi

# Recursive function for Directory Tree Traversal 
traverse () {
    # Changing the IFS environment variable's value so that the traversed file/folder name is parsed without ignoring spaces
    # Typically, the IFS value is a space, but by changing this delimiter to a newline character '\n':
    # We can traverse using for loops without having to worry if a folder/file's name is not butchered
    IFS=$'\n'
    root=$1
    outfile=$2
    if [[ -d "$root" && -r "$root" ]]; then # If the encountered element is a valid folder, i.e. it is a readable directory

        # if a folder is readable then proceed
        if [[ -r "$root" ]]; then
            if  find "$root" -mindepth 1 | read; then # if the folder/directory isn't empty
                echo "<ul>">>"${outfile}"
                for file in "$root/"*;
                do
                    if [[ -d "${file}" ]]; then # if it is a directory -- print into the html document & traverse
                        echo "<li> <b> ${file##*/} </b> </li>">>"${outfile}"
                        traverse $file $outfile
                    else # else if it is a file -- ONLY traverse
                        traverse $file $outfile
                    fi
                done
                echo "</ul>">>"${outfile}"
            fi
        fi
    else # Else it is a file that must be printed into the html document
        if [[ -r "$root" ]]; then # Ensure that the file is readable
            echo "<li> ${root##*/} </li>">>"${outfile}"
        fi
    fi
}

if [[ -d "$rootname" && -r "$rootname" ]]; then # If the root directory/folder is valid, i.e. it is a readable directory
    # Creating the HTML File
    echo "<!DOCTYPE html>">>$outfile
    echo "<html>">>$outfile
    echo "<!body>">>$outfile
    echo "<h1> Directory Tree </h1>">>$outfile
    traverse $rootpath $outfile
fi