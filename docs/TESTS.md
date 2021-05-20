# Tests

Start up your Common Lisp implementation in the directory of the exercise you are working on (or change the current directory for an already running Common Lisp implementation to that directory).

Load the test file into your running Lisp implementation, for example, `(load "exercise-name-test")`. 
(This will also load the solution file for you.)
After the test file is loaded you may run the tests by evaluating `(exercise-name:run-tests)` in the REPL.
(Change "`exercise-name`" to the correct name for the exercise you are working on.)

As you make changes to the solution you are writing use your editor's functionality to load the changes or evaluate `(load "exercise-name")` to load your solution file.

Remember to evaluate `(exercise-name:run-tests)` to re-run the tests after loading your updated solution.


