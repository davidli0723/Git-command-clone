#!/bin/dash

# test pushy-rm two scenario

# scenario 1: file exist in index and commit, same content
# scenario 2: file exist in index and commit, different content


2041 pushy-init
# case1
echo hello > b
2041 pushy-add b
2041 pushy-commit -m commit-0
2041 pushy-rm --cached b
2041 pushy-status
echo "first part done"
# case2
echo line1 > a
2041 pushy-add a
2041 pushy-commit -m commit-1
echo line2 >> a
2041 pushy-rm --cached a
2041 pushy-status

# 2041 pushy-init
# echo line1 > a
# echo hello > b
# 2041 pushy-add a b
# 2041 pushy-commit -m commit-0
# 2041 pushy-show :b
# rm b
# 2041 pushy-show :b
# 2041 pushy-rm b
# echo "break line"
# echo new > b
# 2041 pushy-add b
# 2041 pushy-rm b
# echo test > c
# 2041 pushy-add c
# # rm c
# 2041 pushy-rm c
# echo "done"


# echo "done"



# test pushy-commit -a -m <message> and pushy-show on files already in the index and files not in the index

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

# echo line1 > a
# echo hello > b

# # commit the file to the repository history - not working

# cat > "$expected_output" <<EOF
# nothing to commit
# EOF

# pushy-commit -a -m "first" > "$actual_output" 2>&1

# if ! diff "$expected_output" "$actual_output"; then
#     echo "Failed test"
#     exit 1
# fi

# # add file to the index directory

# cat > "$expected_output" <<EOF
# EOF

# pushy-add a b > "$actual_output" 2>&1

# if ! diff "$expected_output" "$actual_output"; then
#     echo "Failed test"
#     exit 1
# fi

# # commit the file to the repository history

# cat > "$expected_output" <<EOF
# Committed as commit 0
# EOF

# pushy-commit -m "first" > "$actual_output" 2>&1

# if ! diff "$expected_output" "$actual_output"; then
#     echo "Failed test"
#     exit 1
# fi

# # show file in index directory

# cat > "$expected_output" <<EOF
# line1
# EOF

# pushy-show :a > "$actual_output" 2>&1

# if ! diff "$expected_output" "$actual_output"; then
#     echo "Failed test"
#     exit 1
# fi

# # remove file and add new file

# rm a
# echo new > c

# # pushy-commit -a -m <message>

# cat > "$expected_output" <<EOF
# Committed as commit 1
# EOF

# pushy-commit -a -m "second" > "$actual_output" 2>&1

# if ! diff "$expected_output" "$actual_output"; then
#     echo "Failed test"
#     exit 1
# fi

# # pushy-show

# cat > "$expected_output" <<EOF
# pushy-show: error: 'a' not found in index
# EOF

# pushy-show :a > "$actual_output" 2>&1

# if ! diff "$expected_output" "$actual_output"; then
#     echo "Failed test"
#     exit 1
# fi

# cat > "$expected_output" <<EOF
# pushy-show: error: 'a' not found in commit 1
# EOF

# pushy-show 1:a > "$actual_output" 2>&1

# if ! diff "$expected_output" "$actual_output"; then
#     echo "Failed test"
#     exit 1
# fi

# cat > "$expected_output" <<EOF
# pushy-show: error: 'c' not found in index
# EOF

# pushy-show :c > "$actual_output" 2>&1

# if ! diff "$expected_output" "$actual_output"; then
#     echo "Failed test"
#     exit 1
# fi

# cat > "$expected_output" <<EOF
# pushy-show: error: 'c' not found in commit 1
# EOF

# pushy-show 1:c > "$actual_output" 2>&1

# if ! diff "$expected_output" "$actual_output"; then
#     echo "Failed test"
#     exit 1
# fi

# cat > "$expected_output" <<EOF
# hello
# EOF

# pushy-show :b > "$actual_output" 2>&1

# if ! diff "$expected_output" "$actual_output"; then
#     echo "Failed test"
#     exit 1
# fi

# echo "Passed test"
# exit 0
