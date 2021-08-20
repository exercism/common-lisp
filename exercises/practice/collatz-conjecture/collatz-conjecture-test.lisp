;; Ensures that collatz-conjecture.lisp and the testing library are always loaded
(eval-when (:compile-toplevel :load-toplevel :execute)
  (load "collatz-conjecture")
  (quicklisp-client:quickload :fiveam))

;; Defines the testing package with symbols from collatz-conjecture and FiveAM in scope
;; The `run-tests` function is exported for use by both the user and test-runner
(defpackage :collatz-conjecture-test
  (:use :cl :fiveam)
  (:export :run-tests))

;; Enter the testing package
(in-package :collatz-conjecture-test)

;; Define and enter a new FiveAM test-suite
(def-suite* collatz-conjecture-suite)

(test steps-for-1 (is (equal 0 (collatz-conjecture:collatz 1))))

(test steps-for-16 (is (equal 4 (collatz-conjecture:collatz 16))))

(test steps-for-12 (is (equal 9 (collatz-conjecture:collatz 12))))

(test steps-for-1000000 (is (equal 152 (collatz-conjecture:collatz 1000000))))

(test steps-for-0 (is (equal nil (collatz-conjecture:collatz 0))))

(test steps-for-negative (is (equal nil (collatz-conjecture:collatz (- 0 15)))))

(defun run-tests (&optional (test-or-suite 'collatz-conjecture-suite))
  "Provides human readable results of test run. Default to entire suite."
  (run! test-or-suite))
