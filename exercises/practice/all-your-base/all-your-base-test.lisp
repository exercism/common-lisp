;; Ensures that all-your-base.lisp and the testing library are always loaded
(eval-when (:compile-toplevel :load-toplevel :execute)
  (load "all-your-base")
  (quicklisp-client:quickload :fiveam))

;; Defines the testing package with symbols from all-your-base and FiveAM in scope
;; The `run-tests` function is exported for use by both the user and test-runner
(defpackage :all-your-base-test
  (:use :cl :fiveam)
  (:export :run-tests))

;; Enter the testing package
(in-package :all-your-base-test)

;; Define and enter a new FiveAM test-suite
(def-suite* all-your-base-suite)

(test single-bit-one-to-decimal
 (is (equal '(1) (all-your-base:rebase '(1) 2 10))))

(test binary-to-single-decimal
 (is (equal '(5) (all-your-base:rebase '(1 0 1) 2 10))))

(test single-decimal-to-binary
 (is (equal '(1 0 1) (all-your-base:rebase '(5) 10 2))))

(test binary-to-multiple-decimal
 (is (equal '(4 2) (all-your-base:rebase '(1 0 1 0 1 0) 2 10))))

(test decimal-to-binary
 (is (equal '(1 0 1 0 1 0) (all-your-base:rebase '(4 2) 10 2))))

(test trinary-to-hexadecimal
 (is (equal '(2 10) (all-your-base:rebase '(1 1 2 0) 3 16))))

(test hexadecimal-to-trinary
 (is (equal '(1 1 2 0) (all-your-base:rebase '(2 10) 16 3))))

(test number-15-bit-integer
 (is (equal '(6 10 45) (all-your-base:rebase '(3 46 60) 97 73))))

(test empty-list (is (equal '(0) (all-your-base:rebase 'nil 2 10))))

(test single-zero (is (equal '(0) (all-your-base:rebase '(0) 10 2))))

(test multiple-zeros (is (equal '(0) (all-your-base:rebase '(0 0 0) 10 2))))

(test leading-zeros (is (equal '(4 2) (all-your-base:rebase '(0 6 0) 7 10))))

(test input-base-is-one (is (not (all-your-base:rebase '(0) 1 10))))

(test input-base-is-zero (is (not (all-your-base:rebase 'nil 0 10))))

(test input-base-is-negative (is (not (all-your-base:rebase '(1) -2 10))))

(test negative-digit (is (not (all-your-base:rebase '(1 -1 1 0 1 0) 2 10))))

(test invalid-positive-digit
 (is (not (all-your-base:rebase '(1 2 1 0 1 0) 2 10))))

(test output-base-is-one (is (not (all-your-base:rebase '(1 0 1 0 1 0) 2 1))))

(test output-base-is-zero (is (not (all-your-base:rebase '(7) 10 0))))

(test output-base-is-negative (is (not (all-your-base:rebase '(1) 2 -7))))

(test both-bases-are-negative (is (not (all-your-base:rebase '(1) -2 -7))))

(defun run-tests (&optional (test-or-suite 'all-your-base-suite))
  "Provides human readable results of test run. Default to entire suite."
  (run! test-or-suite))
