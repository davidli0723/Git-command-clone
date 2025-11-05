#!/bin/dash

# test pushy-rm two scenario

# scenario 1: file exist in three directories, index content different from working and commit
# scenario 2: file exist in three directories, working content different from index and commit

PATH="$PATH:$(pwd)"

test_dir="$(mktemp -d)"
cd "$test_dir" || exit 1

expected_output="$(mktemp)"
actual_output="$(mktemp)"

trap 'rm "$expected_output" "$actual_output" -rf "$test_dir"' INT HUP QUIT TERM EXIT

# Create pushy repository

cat > "$expected_output" <<EOF
Initialized empty pushy repository in .pushy
EOF

pushy-init > "$actual_output" 2>&1

if ! diff "$expected_output" "$actual_output"; then
    echo "Failed test"
    exit 1
fi

# Scenario 1
# Create files.

echo hello > b

# add file to the index directory

cat > "$expected_output" <<EOF
EOF

pushy-add b > "$actual_output" 2>&1

if ! diff "$expected_output" "$actual_output"; then
    echo "Failed test"
    exit 1
fi

# commit

cat > "$expected_output" <<EOF
Committed as commit 0
EOF

pushy-commit -m commit-0 > "$actual_output" 2>&1

if ! diff "$expected_output" "$actual_output"; then
    echo "Failed test"
    exit 1
fi

# add line in file
echo world >> b

# add file to the index directory

cat > "$expected_output" <<EOF
EOF

pushy-add b > "$actual_output" 2>&1

if ! diff "$expected_output" "$actual_output"; then
    echo "Failed test"
    exit 1
fi

# overwrite file content
echo hello > b

# show file in commit number

cat > "$expected_output" <<EOF
hello
world
EOF

pushy-show :b > "$actual_output" 2>&1

if ! diff "$expected_output" "$actual_output"; then
    echo "Failed test"
    exit 1
fi

# pushy-rm b

cat > "$expected_output" <<EOF
pushy-rm: error: 'b' in index is different to both the working file and the repository
EOF

pushy-rm b > "$actual_output" 2>&1

if ! diff "$expected_output" "$actual_output"; then
    echo "Failed test"
    exit 1
fi


# Scenario 2
# add new file

echo line1 > a

# add file to index

cat > "$expected_output" <<EOF
EOF

pushy-add a > "$actual_output" 2>&1

if ! diff "$expected_output" "$actual_output"; then
    echo "Failed test"
    exit 1
fi

# commit

cat > "$expected_output" <<EOF
Committed as commit 1
EOF

pushy-commit -m commit-1 > "$actual_output" 2>&1

if ! diff "$expected_output" "$actual_output"; then
    echo "Failed test"
    exit 1
fi

# show file a content with commit number

cat > "$expected_output" <<EOF
line1
EOF

pushy-show 1:a > "$actual_output" 2>&1

if ! diff "$expected_output" "$actual_output"; then
    echo "Failed test"
    exit 1
fi

# add new line in file

echo line2 >> a

# pushy-rm a

cat > "$expected_output" <<EOF
pushy-rm: error: 'a' in the repository is different to the working file
EOF

pushy-rm a > "$actual_output" 2>&1

if ! diff "$expected_output" "$actual_output"; then
    echo "Failed test"
    exit 1
fi

# show file a content with commit number

cat > "$expected_output" <<EOF
line1
EOF

pushy-show :a > "$actual_output" 2>&1

if ! diff "$expected_output" "$actual_output"; then
    echo "Failed test"
    exit 1
fi

echo "Passed test"
exit 0
