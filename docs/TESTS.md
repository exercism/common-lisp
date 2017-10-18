Start up your Lisp implementation in the directory of the exercise you
are working on (or change the current directory for an already running
Lisp implementation to that directory).

Load the test file into your running Lisp implementation, for example,
`(load "point-mutations-test")`. This will run the tests the first
time automatically. After that you can run the test suite in the REPL
with `(lisp-unit:run-tests :all :point-mutations-test)`.

## Making your first Common Lisp solution

To create lisp code that can be loaded with `#-xlisp-test (load "hamming")`
for the first exercise, put this code in `hamming.lisp`:

```lisp
(defpackage #:hamming
  (:use #:cl)
  (:export #:distance))

(in-package #:hamming)

(defun distance (dna1 dna2)
  "Number of positional differences in two equal length dna strands."
  ;;; your solution here
  )
```

Then you can run the test with one of these commands

```
clisp -i ~/.clisprc.lisp hamming-test.lisp
```

That way you load your `.clisprc.lisp` which will be loading the quickload then running the test. Or you can do it like this

```
clisp -i hamming-test.lisp -x '(ext:exit)'
```


*Notes:* Remember you should install the quickload before doing this.
