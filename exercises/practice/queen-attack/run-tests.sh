#!/bin/sh
exercise=${PWD##*/}
tests="${exercise}-test.lisp"

if ! [ -f "${tests}" ]; then
    echo "Test file not found: $tests" >&2
    exit 2
fi

# exit status: 0 if all tests pass, 1 otherwise
ros run --load "${tests}" \
        --eval "(uiop:quit (if (${exercise}-test:run-tests) 0 1))"
