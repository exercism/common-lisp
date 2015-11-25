Load the test file into your running Lisp implementation, for example,
`(load "point-mutations-test")`. This will run the tests the first
time automatically. After that you can run the test suite in the REPL
with `(lisp-unit:run-tests :all :point-mutations-test)`.

## Making your first Common Lisp solution

To create lisp code that can be loaded with `(load "dna")`
for the first exercise, put this code in `dna.lisp`:

```lisp
(in-package #:cl-user)
(defpackage #:dna
  (:use #:common-lisp)
  (:export #:hamming-distance))

(in-package #:dna)

(defun hamming-distance (dna1 dna2)
  "Determine number of mutations between DNA strands by computing the Hamming Distance."
  )
```
