#!/bin/dash

# test pushy-rm three scenario

# scenario 1: file exist in index directory only
# scenario 2: file exist in working and index directory, same content
# scenario 3: file exist in working and index directory, different content


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

# show file in index directory

cat > "$expected_output" <<EOF
hello
EOF

pushy-show :b > "$actual_output" 2>&1

if ! diff "$expected_output" "$actual_output"; then
    echo "Failed test"
    exit 1
fi

# remove b in working directory
rm b

# commit the file to the repository history

cat > "$expected_output" <<EOF
EOF

pushy-rm b > "$actual_output" 2>&1

if ! diff "$expected_output" "$actual_output"; then
    echo "Failed test"
    exit 1
fi

# show file in index directory

cat > "$expected_output" <<EOF
pushy-show: error: 'b' not found in index
EOF

pushy-show :b > "$actual_output" 2>&1

if ! diff "$expected_output" "$actual_output"; then
    echo "Failed test"
    exit 1
fi

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

# pushy-rm a

cat > "$expected_output" <<EOF
pushy-rm: error: 'a' has staged changes in the index
EOF

pushy-rm a > "$actual_output" 2>&1

if ! diff "$expected_output" "$actual_output"; then
    echo "Failed test"
    exit 1
fi

# add new line to file

echo line2 >> a

# pushy-rm a

cat > "$expected_output" <<EOF
pushy-rm: error: 'a' in index is different to both the working file and the repository
EOF

pushy-rm a > "$actual_output" 2>&1

if ! diff "$expected_output" "$actual_output"; then
    echo "Failed test"
    exit 1
fi

echo "Passed test"
exit 0
