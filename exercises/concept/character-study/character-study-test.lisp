;; Ensures that character-study.lisp and the testing library are always loaded
(eval-when (:compile-toplevel :load-toplevel :execute)
  (load "character-study")
  (ql:quickload :fiveam))

;; Defines the testing package with symbols from character-study and FiveAM in scope
;; The `run-tests` function is exported for use by both the user and test-runner
(defpackage :character-study-test
  (:use :cl :fiveam :character-study)
  (:export :run-tests))

;; Enter the testing package
(in-package :character-study-test)

;; Either provides human-readable results to the user or machine-readable
;; results to the test runner. The default upon calling `(run-tests)` is to
;; explain the results in a human-readable way
(defun run-tests (&optional (explain t))
  (let ((tests (run 'character-study-suite))) ; Run the tests once
    (if explain (explain! tests) tests))) ; Optionally explain the results
