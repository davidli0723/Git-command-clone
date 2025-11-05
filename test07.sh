#!/bin/dash

# test pushy-rm two scenario

# scenario 1: file exist in index and commit, same content
# scenario 2: file exist in index and commit, different content

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

# remove b in working directory
rm b

# show file in commit number

cat > "$expected_output" <<EOF
hello
EOF

pushy-show :b > "$actual_output" 2>&1

if ! diff "$expected_output" "$actual_output"; then
    echo "Failed test"
    exit 1
fi

# pushy-rm -cached b

cat > "$expected_output" <<EOF
EOF

pushy-rm --cached b > "$actual_output" 2>&1

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

# add new line in file

echo line2 >> a

# add file to index

cat > "$expected_output" <<EOF
EOF

pushy-add a > "$actual_output" 2>&1

if ! diff "$expected_output" "$actual_output"; then
    echo "Failed test"
    exit 1
fi

# remove file in working directory

rm a

# pushy-rm a

cat > "$expected_output" <<EOF
EOF

pushy-rm --cached a > "$actual_output" 2>&1

if ! diff "$expected_output" "$actual_output"; then
    echo "Failed test"
    exit 1
fi

# show file a content with commit number

cat > "$expected_output" <<EOF
pushy-show: error: 'a' not found in index
EOF

pushy-show :a > "$actual_output" 2>&1

if ! diff "$expected_output" "$actual_output"; then
    echo "Failed test"
    exit 1
fi

echo "Passed test"
exit 0
