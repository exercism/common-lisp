# Tests

## Testing interactively

Start the REPL from the directory that you downloaded the exercise to.

You can run the tests by loading the test file into the REPL with `(load "exercise-test")` (replacing "exercise" with appropriate name). Then evaluate `(exercise-test:run-tests)` to run all the tests.

If you write your code directly in the REPL then simply evaluate `(exercise-test:run-tests)`.

If you write your code in the exercise lisp file then load it with `(load "exercise")` then evaluate `(exercise-test:run-tests)`.

## Testing from the command line

You can launch the tests with this command line invocation (again, replace "exercise" with the appropriate name in two places)

```sh
ros run --load exercise-test.lisp --eval '(uiop:quit (if (exercise-test:run-tests) 0 1))'
```
