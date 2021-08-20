;; Ensures that grains.lisp and the testing library are always loaded
(eval-when (:compile-toplevel :load-toplevel :execute)
  (load "grains")
  (quicklisp-client:quickload :fiveam))

;; Defines the testing package with symbols from grains and FiveAM in scope
;; The `run-tests` function is exported for use by both the user and test-runner
(defpackage :grains-test
  (:use :cl :fiveam)
  (:export :run-tests))

;; Enter the testing package
(in-package :grains-test)

;; Define and enter a new FiveAM test-suite
(def-suite* grains-suite)

(test square-1 (is (equal 1 (grains:square 1))))

(test square-2 (is (equal 2 (grains:square 2))))

(test square-3 (is (equal 4 (grains:square 3))))

(test square-4 (is (equal 8 (grains:square 4))))

(test square-16 (is (equal 32768 (grains:square 16))))

(test square-32 (is (equal 2147483648 (grains:square 32))))

(test square-64 (is (equal 9223372036854775808 (grains:square 64))))

(test total-grains (is (equal 18446744073709551615 (grains:total))))

(defun run-tests (&optional (test-or-suite 'grains-suite))
  "Provides human readable results of test run. Default to entire suite."
  (run! test-or-suite))
