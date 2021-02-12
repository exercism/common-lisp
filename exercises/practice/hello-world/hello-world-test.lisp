;; Ensures that key-comparison.lisp and the testing library are always loaded
(eval-when (:compile-toplevel :load-toplevel :execute)
  (load "hello-world")
  (ql:quickload :fiveam))

;; Defines the testing package with FiveAM in scope
;; The `run-tests` function is exported for use by both the user and test-runner
(defpackage :hello-world-test
  (:use :cl :fiveam)
  (:export :run-tests))

;; Enter the testing package
(in-package :hello-world-test)

;; Define and enter a new FiveAM test-suite
(def-suite hello-world-suite)
(in-suite hello-world-suite)

(test say-hi
      (is (string= "Hello, World!" (hello-world:hello))))

;; Either provides human-readable results to the user or machine-readable
;; results to the test runner. The default upon calling `(run-tests)` is to
;; explain the results in a human-readable way
(defun run-tests (&optional (explain t))
  (let ((tests (run 'hello-world-suite))) ; Run the tests once
    (if explain (explain! tests) tests))) ; Optionally explain the results
