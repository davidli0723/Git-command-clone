#!/bin/dash

2041 pushy-init
echo line1 > a
echo hello > b
2041 pushy-add a b
2041 pushy-commit -m "first"
2041 pushy-show :a
rm a
echo new > c
2041 pushy-commit -a -m "second"
2041 pushy-show :a
2041 pushy-show 1:a
2041 pushy-show :c
2041 pushy-show 1:c
2041 pushy-show :b

# test add file and show file in folder

# PATH="$PATH:$(pwd)"

# test_dir="$(mktemp -d)"
# cd "$test_dir" || exit 1

# expected_output="$(mktemp)"
# actual_output="$(mktemp)"

# trap 'rm "$expected_output" "$actual_output" -rf "$test_dir"' INT HUP QUIT TERM EXIT

# # Create pushy repository

# cat > "$expected_output" <<EOF
# Initialized empty pushy repository in .pushy
# EOF

# pushy-init > "$actual_output" 2>&1

# if ! diff "$expected_output" "$actual_output"; then
#     echo "Failed test"
#     exit 1
# fi

# # Create files.

# touch a b c

# # add non existence file to the repository staging area

# cat > "$expected_output" <<EOF
# pushy-add: error: can not open 'd'
# EOF

# pushy-add a d e > "$actual_output" 2>&1

# if ! diff "$expected_output" "$actual_output"; then
#     echo "Failed test"
#     exit 1
# fi

# # check file 'a' content using pushy-show :a

# cat > "$expected_output" <<EOF
# pushy-show: error: 'a' not found in index
# EOF

# pushy-show :a > "$actual_output" 2>&1

# if ! diff "$expected_output" "$actual_output"; then
#     echo "Failed test"
#     exit 1
# fi