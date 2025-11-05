#!/bin/dash

# test all commands with no previous init

PATH="$PATH:$(pwd)"

test_dir="$(mktemp -d)"
cd "$test_dir" || exit 1

expected_output="$(mktemp)"
actual_output="$(mktemp)"

trap 'rm "$expected_output" "$actual_output" -rf "$test_dir"' INT HUP QUIT TERM EXIT

# test all command without pushy-init

# pushy-add a
cat > "$expected_output" <<EOF
pushy-add: error: pushy repository directory .pushy not found
EOF

pushy-add a > "$actual_output" 2>&1

if ! diff "$expected_output" "$actual_output"; then
    echo "Failed test"
    exit 1
fi

# pushy-commit -m "first"

cat > "$expected_output" <<EOF
pushy-commit: error: pushy repository directory .pushy not found
EOF

pushy-commit -m "first" > "$actual_output" 2>&1

if ! diff "$expected_output" "$actual_output"; then
    echo "Failed test"
    exit 1
fi

# pushy-log

cat > "$expected_output" <<EOF
pushy-log: error: pushy repository directory .pushy not found
EOF

pushy-log > "$actual_output" 2>&1

if ! diff "$expected_output" "$actual_output"; then
    echo "Failed test"
    exit 1
fi

# pushy-show :a

cat > "$expected_output" <<EOF
pushy-show: error: pushy repository directory .pushy not found
EOF

pushy-show :a > "$actual_output" 2>&1

if ! diff "$expected_output" "$actual_output"; then
    echo "Failed test"
    exit 1
fi

# pushy-rm a

cat > "$expected_output" <<EOF
pushy-rm: error: pushy repository directory .pushy not found
EOF

pushy-rm a > "$actual_output" 2>&1

if ! diff "$expected_output" "$actual_output"; then
    echo "Failed test"
    exit 1
fi

# pushy-status

cat > "$expected_output" <<EOF
pushy-status: error: pushy repository directory .pushy not found
EOF

pushy-status > "$actual_output" 2>&1

if ! diff "$expected_output" "$actual_output"; then
    echo "Failed test"
    exit 1
fi

# pushy-branch b1

cat > "$expected_output" <<EOF
pushy-branch: error: pushy repository directory .pushy not found
EOF

pushy-branch b1 > "$actual_output" 2>&1

if ! diff "$expected_output" "$actual_output"; then
    echo "Failed test"
    exit 1
fi

# pushy-checkout master

cat > "$expected_output" <<EOF
pushy-checkout: error: pushy repository directory .pushy not found
EOF

pushy-checkout master > "$actual_output" 2>&1

if ! diff "$expected_output" "$actual_output"; then
    echo "Failed test"
    exit 1
fi

echo "Passed test"
exit 0