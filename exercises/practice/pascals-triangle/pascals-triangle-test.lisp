;; Ensures that pascals-triangle.lisp and the testing library are always loaded
(eval-when (:compile-toplevel :load-toplevel :execute)
  (load "pascals-triangle")
  (quicklisp-client:quickload :fiveam))

;; Defines the testing package with symbols from pascals-triangle and FiveAM in scope
;; The `run-tests` function is exported for use by both the user and test-runner
(defpackage :pascals-triangle-test
  (:use :cl :fiveam)
  (:export :run-tests))

;; Enter the testing package
(in-package :pascals-triangle-test)

;; Define and enter a new FiveAM test-suite
(def-suite* pascals-triangle-suite)

(test zero-rows (is (equal 'nil (pascals-triangle:rows 0))))

(test single-row (is (equal '((1)) (pascals-triangle:rows 1))))

(test two-rows (is (equal '((1) (1 1)) (pascals-triangle:rows 2))))

(test three-rows (is (equal '((1) (1 1) (1 2 1)) (pascals-triangle:rows 3))))

(test four-rows
 (is (equal '((1) (1 1) (1 2 1) (1 3 3 1)) (pascals-triangle:rows 4))))

(test negative-rows (is (equal 'nil (pascals-triangle:rows -1))))

(defun run-tests (&optional (test-or-suite 'pascals-triangle-suite))
  "Provides human readable results of test run. Default to entire suite."
  (run! test-or-suite))
