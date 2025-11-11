# Git-command-clone

This project implements Pushy by Shell Script, a simple but powerful subset of the version control system Git.
Test cases are written to validate the correctness of the implementation.

# Available command

- pushy-init: Create an empty Pushy repository.
- pushy-add filenames...: adds the contents of one or more files to the index.
- pushy-commit [-a] -m message: saves a copy of all files in the index to the repository.
-a option, which causes all files already in the index to have their contents from the current directory added to the index before the commit.
- pushy-log: prints a line for every commit made to the repository.
- pushy-show [commit]:filename: print the contents of the specified filename as of the specified commit.
- pushy-rm [--force] [--cached] filenames...: removes a file from the index, or, from the current directory and the index.
--cached option is specified, the file is removed only from the index, and not from the current directory.
--force option overrides this, and will carry out the removal even if the user will lose work.
- pushy-status: shows the status of files in the current directory, the index, and the repository.
