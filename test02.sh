#!/bin/dash

# test correct input of commands

PATH="$PATH:$(pwd)"

test_dir="$(mktemp -d)"
cd "$test_dir" || exit 1

expected_output="$(mktemp)"
actual_output="$(mktemp)"

trap 'rm "$expected_output" "$actual_output" -rf "$test_dir"' INT HUP QUIT TERM EXIT

# test the output error if wrong command usage

# check invalid use of pushy-init give an error

cat > "$expected_output" <<EOF
usage: pushy-init
EOF

pushy-init zzz > "$actual_output" 2>&1

if ! diff "$expected_output" "$actual_output"; then
    echo "Failed test"
    exit 1
fi

# Create pushy repository

cat > "$expected_output" <<EOF
Initialized empty pushy repository in .pushy
EOF

pushy-init > "$actual_output" 2>&1

if ! diff "$expected_output" "$actual_output"; then
    echo "Failed test"
    exit 1
fi

# check invalid use of pushy-add give an error

cat > "$expected_output" <<EOF
usage: pushy-add <filenames>
EOF

pushy-add > "$actual_output" 2>&1

if ! diff "$expected_output" "$actual_output"; then
    echo "Failed test"
    exit 1
fi

# check invalid use of pushy-commit give an error

# less than two arguments
cat > "$expected_output" <<EOF
usage: pushy-commit [-a] -m commit-message
EOF

pushy-commit -m > "$actual_output" 2>&1

if ! diff "$expected_output" "$actual_output"; then
    echo "Failed test"
    exit 1
fi

# more than three arguments
cat > "$expected_output" <<EOF
usage: pushy-commit [-a] -m commit-message
EOF

pushy-commit -a -m hello world > "$actual_output" 2>&1

if ! diff "$expected_output" "$actual_output"; then
    echo "Failed test"
    exit 1
fi

# check invalid use of pushy-show give an error

# zero argument
cat > "$expected_output" <<EOF
usage: pushy-show <commit>:<filename>
EOF

pushy-show > "$actual_output" 2>&1

if ! diff "$expected_output" "$actual_output"; then
    echo "Failed test"
    exit 1
fi

# more than one arguments
cat > "$expected_output" <<EOF
usage: pushy-show <commit>:<filename>
EOF

pushy-show 1:a 1:a > "$actual_output" 2>&1

if ! diff "$expected_output" "$actual_output"; then
    echo "Failed test"
    exit 1
fi

# missing ":" in the first arguement
cat > "$expected_output" <<EOF
usage: pushy-show <commit>:<filename>
EOF

pushy-show a > "$actual_output" 2>&1

if ! diff "$expected_output" "$actual_output"; then
    echo "Failed test"
    exit 1
fi

# check invalid use of pushy-log give an error

cat > "$expected_output" <<EOF
usage: pushy-log
EOF

pushy-log zzz > "$actual_output" 2>&1

if ! diff "$expected_output" "$actual_output"; then
    echo "Failed test"
    exit 1
fi

# check invalid use of pushy-rm give an error

cat > "$expected_output" <<EOF
usage: pushy-rm [--force] [--cached] <filenames>
EOF

pushy-rm --force --cached > "$actual_output" 2>&1

if ! diff "$expected_output" "$actual_output"; then
    echo "Failed test"
    exit 1
fi

cat > "$expected_output" <<EOF
usage: pushy-rm [--force] [--cached] <filenames>
EOF

pushy-rm --force > "$actual_output" 2>&1

if ! diff "$expected_output" "$actual_output"; then
    echo "Failed test"
    exit 1
fi

cat > "$expected_output" <<EOF
usage: pushy-rm [--force] [--cached] <filenames>
EOF

pushy-rm --cached > "$actual_output" 2>&1

if ! diff "$expected_output" "$actual_output"; then
    echo "Failed test"
    exit 1
fi

cat > "$expected_output" <<EOF
usage: pushy-rm [--force] [--cached] <filenames>
EOF

pushy-rm -force -cached a b > "$actual_output" 2>&1

if ! diff "$expected_output" "$actual_output"; then
    echo "Failed test"
    exit 1
fi

cat > "$expected_output" <<EOF
usage: pushy-rm [--force] [--cached] <filenames>
EOF

pushy-rm --f -cached b d e > "$actual_output" 2>&1

if ! diff "$expected_output" "$actual_output"; then
    echo "Failed test"
    exit 1
fi

cat > "$expected_output" <<EOF
usage: pushy-rm [--force] [--cached] <filenames>
EOF

pushy-rm --force -c b d e > "$actual_output" 2>&1

if ! diff "$expected_output" "$actual_output"; then
    echo "Failed test"
    exit 1
fi

# check invalid use of pushy-status give an error

cat > "$expected_output" <<EOF
usage: pushy-status
EOF

pushy-status zzz > "$actual_output" 2>&1

if ! diff "$expected_output" "$actual_output"; then
    echo "Failed test"
    exit 1
fi

echo "Passed test"
exit 0