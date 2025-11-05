#!/bin/dash

# test all subset0 and subset1 command

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

# remove file in working directory
rm b

# show file status

cat > "$expected_output" <<EOF
b - file deleted
EOF

pushy-status > "$actual_output" 2>&1

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

# pushy-add a

cat > "$expected_output" <<EOF
EOF

pushy-add a > "$actual_output" 2>&1

if ! diff "$expected_output" "$actual_output"; then
    echo "Failed test"
    exit 1
fi

# remove file in working directory
rm a

# show file status

cat > "$expected_output" <<EOF
a - file deleted, changes staged for commit
b - file deleted
EOF

pushy-status > "$actual_output" 2>&1

if ! diff "$expected_output" "$actual_output"; then
    echo "Failed test"
    exit 1
fi


# add new file

echo new > c

# add file to index

cat > "$expected_output" <<EOF
EOF

pushy-add c > "$actual_output" 2>&1

if ! diff "$expected_output" "$actual_output"; then
    echo "Failed test"
    exit 1
fi

# commit

cat > "$expected_output" <<EOF
Committed as commit 2
EOF

pushy-commit -m commit-2 > "$actual_output" 2>&1

if ! diff "$expected_output" "$actual_output"; then
    echo "Failed test"
    exit 1
fi

# add new line in file

echo old >> c

# pushy-add c

cat > "$expected_output" <<EOF
EOF

pushy-add c > "$actual_output" 2>&1

if ! diff "$expected_output" "$actual_output"; then
    echo "Failed test"
    exit 1
fi

# overwrite file

echo new > c

# show file a content with commit number

cat > "$expected_output" <<EOF
new
old
EOF

pushy-show :c > "$actual_output" 2>&1

if ! diff "$expected_output" "$actual_output"; then
    echo "Failed test"
    exit 1
fi

# show file a content with commit number

cat > "$expected_output" <<EOF
new
EOF

pushy-show 2:c > "$actual_output" 2>&1

if ! diff "$expected_output" "$actual_output"; then
    echo "Failed test"
    exit 1
fi

# show file status

cat > "$expected_output" <<EOF
a - file deleted
b - file deleted
c - file changed, different changes staged for commit
EOF

pushy-status > "$actual_output" 2>&1

if ! diff "$expected_output" "$actual_output"; then
    echo "Failed test"
    exit 1
fi

# commit

cat > "$expected_output" <<EOF
Committed as commit 3
EOF

pushy-commit -m commit-3 > "$actual_output" 2>&1

if ! diff "$expected_output" "$actual_output"; then
    echo "Failed test"
    exit 1
fi

# pushy-add c

cat > "$expected_output" <<EOF
EOF

pushy-add c > "$actual_output" 2>&1

if ! diff "$expected_output" "$actual_output"; then
    echo "Failed test"
    exit 1
fi

# overwrite file

echo zzz > c

# show file status

cat > "$expected_output" <<EOF
a - file deleted
b - file deleted
c - file changed, different changes staged for commit
EOF

pushy-status > "$actual_output" 2>&1

if ! diff "$expected_output" "$actual_output"; then
    echo "Failed test"
    exit 1
fi

# commit

cat > "$expected_output" <<EOF
Committed as commit 4
EOF

pushy-commit -a -m commit-4 > "$actual_output" 2>&1

if ! diff "$expected_output" "$actual_output"; then
    echo "Failed test"
    exit 1
fi

# show file status

cat > "$expected_output" <<EOF
c - same as repo
EOF

pushy-status > "$actual_output" 2>&1

if ! diff "$expected_output" "$actual_output"; then
    echo "Failed test"
    exit 1
fi

# remove file

rm c

# commit

cat > "$expected_output" <<EOF
Committed as commit 5
EOF

pushy-commit -a -m commit-5 > "$actual_output" 2>&1

if ! diff "$expected_output" "$actual_output"; then
    echo "Failed test"
    exit 1
fi

# commit

cat > "$expected_output" <<EOF
5 commit-5
4 commit-4
3 commit-3
2 commit-2
1 commit-1
0 commit-0
EOF

pushy-log > "$actual_output" 2>&1

if ! diff "$expected_output" "$actual_output"; then
    echo "Failed test"
    exit 1
fi

# show file status

cat > "$expected_output" <<EOF
EOF

pushy-status > "$actual_output" 2>&1

if ! diff "$expected_output" "$actual_output"; then
    echo "Failed test"
    exit 1
fi


echo "Passed test"
exit 0
