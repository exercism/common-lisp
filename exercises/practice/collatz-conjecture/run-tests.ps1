
$exercise = Split-Path -Path $PSScriptRoot -Leaf
$tests = $exercise + "-test.lisp"

if (-Not (Test-Path -Path $tests)) {
    Write-Error "Test file not found: $tests"
} else {
    ros run --load $tests `
            --eval "(uiop:quit (if (${exercise}-test:run-tests) 0 1))"
}
