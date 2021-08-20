;; Ensures that difference-of-squares.lisp and the testing library are always loaded
(eval-when (:compile-toplevel :load-toplevel :execute)
  (load "difference-of-squares")
  (quicklisp-client:quickload :fiveam))

;; Defines the testing package with symbols from difference-of-squares and FiveAM in scope
;; The `run-tests` function is exported for use by both the user and test-runner
(defpackage :difference-of-squares-test
  (:use :cl :fiveam)
  (:export :run-tests))

;; Enter the testing package
(in-package :difference-of-squares-test)

;; Define and enter a new FiveAM test-suite
(def-suite* difference-of-squares-suite)

(test square-of-sum-to-5
 (is (equal 225 (difference-of-squares:square-of-sum 5))))

(test sum-of-squares-to-5
 (is (equal 55 (difference-of-squares:sum-of-squares 5))))

(test difference-of-sums-to-5
 (is (equal 170 (difference-of-squares:difference 5))))

(test square-of-sum-to-10
 (is (equal 3025 (difference-of-squares:square-of-sum 10))))

(test sum-of-squares-to-10
 (is (equal 385 (difference-of-squares:sum-of-squares 10))))

(test difference-of-sums-to-10
 (is (equal 2640 (difference-of-squares:difference 10))))

(test square-of-sum-to-100
 (is (equal 25502500 (difference-of-squares:square-of-sum 100))))

(test sum-of-squares-to-100
 (is (equal 338350 (difference-of-squares:sum-of-squares 100))))

(test difference-of-sums-to-100
 (is (equal 25164150 (difference-of-squares:difference 100))))

(defun run-tests (&optional (test-or-suite 'difference-of-squares-suite))
  "Provides human readable results of test run. Default to entire suite."
  (run! test-or-suite))
