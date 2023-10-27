# Tests

Start up your Common Lisp implementation in the directory of the exercise you are working on (or change the current directory for an already running Common Lisp implementation to that directory).

(All examples here assume an exercise called `exercise-name` - adjust s needed.)

Load the test file into your running Lisp implementation, for example, `(load "exercise-name-test")`. 
(This will also load the solution file for you.)
After the test file is loaded you may run the tests by evaluating `(exercise-name-test:run-tests)` in the REPL.

As you make changes to the solution you are writing use your editor's functionality to load the changes or evaluate `(load "exercise-name")` to load your solution file.

Remember to evaluate `(exercise-name-test:run-tests)` to re-run the tests after loading your updated solution.

## Testing from the command line

Executing the tests from the command line is possible, but it depends on which CL implementation you have chosen.
For example, with SBCL you could execute this in the directory for exercise "foo"

```sh
sbcl --noinform \
     --load foo-test \
     --eval '(exit :code (if (foo-test:run-tests) 0 1))'
```

Other CL implementations will have similar but slightly different command-line options and exit commands.

This assumes you have already installed SBCL and Quicklisp.
See [Installing Common Lisp locally](https://exercism.org/docs/tracks/common-lisp/installation)

~~~~exercism/note
That command can be made more convenient. The `exercism` CLI has been updated so that the command

```sh
exercism test
```

does "The Right Thing"™ to invoke the test suite for _most tracks_.
Unfortunately CL does not benefit because there is no single prescribed way to run the tests.

However, there are ways to wrap the exercism CLI to provide additional functionality, or override existing functionality.
If you use the bash shell, you can add the following to your `~/.bashrc` file.
It looks complicated but it just checks that you are in a directory for a CL exercise and invokes SBCL:

```sh
function exercism {
    if [[ $1 == "test" && $PWD =~ "$(command exercism workspace)/common-lisp/"([^/]+) ]]
    then
        local exercise=${BASH_REMATCH[1]}
        sbcl --noinform \
             --load "${exercise}-test" \
             --eval "(exit :code (if (${exercise}-test:run-tests) 0 1))"
    else
        command exercism "$@"
    fi
}
```

With that, you can run `exercism test` to run the tests for your CL exercises.
~~~~
