# Unix-Directory-Site-Map

### Date: March 1 2021

## Task:

This Bash shell script performs a traversal on a directory tree and generates a site map onto an HTML document.

## Criteria:

- Implementing a tree traversal **without using the tree** command, and only regular Linux distribution commands.
- Implementing a recursive solution to perform this traversal.
- Printing the built tree into an HTML document.
- Error handling for edge cases.

### Requirements and Running it locally:

1. Run the script on a Bash (or even zsh) shell as certain commands may not be compatible with other shells.
2. The script takes in two command line arguments, the first argument for the root of the directory to scan, and the second argument for the name of the output file (i.e. the HTML doc).
3. On a successfull traversal, the script generates an HTML document within the same directory containing this script.

## SYNTAX, Aspects and Limitations:

### EXAMPLE:

In order to run the script.sh and generate an output file named output.html, you must enter the command as follows in that directory:

$ ./script.sh ~/output.html
