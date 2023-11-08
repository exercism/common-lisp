# Tests

## Testing interactively

Start up your Common Lisp implementation in the directory of the exercise you are working on (or change the current directory for an already running Common Lisp implementation to that directory).
Using roswell, do this with `ros run`.

(All examples here assume an exercise called `exercise-name` - adjust as needed.)

Load the test file into your running Lisp implementation, for example, `(load "exercise-name-test")`. 
(This will also load the solution file for you.)
After the test file is loaded you may run the tests by evaluating `(exercise-name-test:run-tests)` in the REPL.

As you make changes to the solution you are writing use your editor's functionality to load the changes or evaluate `(load "exercise-name")` to load your solution file.

Remember to evaluate `(exercise-name-test:run-tests)` to re-run the tests after loading your updated solution.

## Testing from the command line

You can launch the tests with this command line invocation (again, replace "exercise" with the appropriate name in two places)

```sh
ros run --load exercise-test.lisp --eval '(uiop:quit (if (exercise-test:run-tests) 0 1))'
```

That command is pretty unwieldy.
A contributor has written some notes about [how to make it easier to invoke](https://glennj.github.io/exercism/cli).
