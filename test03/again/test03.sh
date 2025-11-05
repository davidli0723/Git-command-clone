#!/bin/dash

2041 pushy-init
echo line1 > a
echo hello > b
2041 pushy-commit -a -m "first"
2041 pushy-add a b
2041 pushy-log
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

# test pushy-commit -a -m <message> and pushy-show on files already in the index and files not in the index

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

echo line1 > a
echo hello > b

# commit the file to the repository history - not working

cat > "$expected_output" <<EOF
nothing to commit
EOF

pushy-commit -a -m "first" > "$actual_output" 2>&1

if ! diff "$expected_output" "$actual_output"; then
    echo "Failed test"
    exit 1
fi

# add file to the index directory

cat > "$expected_output" <<EOF
EOF

pushy-add a b > "$actual_output" 2>&1

if ! diff "$expected_output" "$actual_output"; then
    echo "Failed test"
    exit 1
fi

# commit the file to the repository history

cat > "$expected_output" <<EOF
Commited as commit 0
EOF

pushy-commit -m "first" > "$actual_output" 2>&1

if ! diff "$expected_output" "$actual_output"; then
    echo "Failed test"
    exit 1
fi

# commit the file to the repository history

cat > "$expected_output" <<EOF
Commited as commit 0
EOF

pushy-show :a > "$actual_output" 2>&1

if ! diff "$expected_output" "$actual_output"; then
    echo "Failed test"
    exit 1
fi



echo "Passed test"
exit 0
