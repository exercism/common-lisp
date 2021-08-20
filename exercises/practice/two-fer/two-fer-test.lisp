;; Ensures that two-fer.lisp and the testing library are always loaded
(eval-when (:compile-toplevel :load-toplevel :execute)
  (load "two-fer")
  (quicklisp-client:quickload :fiveam))

;; Defines the testing package with symbols from two-fer and FiveAM in scope
;; The `run-tests` function is exported for use by both the user and test-runner
(defpackage :two-fer-test
  (:use :cl :fiveam)
  (:export :run-tests))

;; Enter the testing package
(in-package :two-fer-test)

;; Define and enter a new FiveAM test-suite
(def-suite* two-fer-suite)

(test no-name-given-nil
 (is (equal "One for you, one for me." (two-fer:twofer nil))))

(test a-name-given
 (is (equal "One for Alice, one for me." (two-fer:twofer "Alice"))))

(test another-name-given
 (is (equal "One for Bob, one for me." (two-fer:twofer "Bob"))))

(test no-name-given (is (equal "One for you, one for me." (two-fer:twofer))))

(defun run-tests (&optional (test-or-suite 'two-fer-suite))
  "Provides human readable results of test run. Default to entire suite."
  (run! test-or-suite))
