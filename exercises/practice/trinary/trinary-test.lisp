;; Ensures that trinary.lisp and the testing library are always loaded
(eval-when (:compile-toplevel :load-toplevel :execute)
  (load "trinary")
  (quicklisp-client:quickload :fiveam))

;; Defines the testing package with symbols from trinary and FiveAM in scope
;; The `run-tests` function is exported for use by both the user and test-runner
(defpackage :trinary-test
  (:use :cl :fiveam)
  (:export :run-tests))

;; Enter the testing package
(in-package :trinary-test)

;; Define and enter a new FiveAM test-suite
(def-suite* trinary-suite)

(test trinary-1-is-decimal-1 (is (equal 1 (trinary:to-decimal "1"))))

(test trinary-2-is-decimal-2 (is (equal 2 (trinary:to-decimal "2"))))

(test trinary-10-is-decimal-3 (is (equal 3 (trinary:to-decimal "10"))))

(test trinary-11-is-decimal-4 (is (equal 4 (trinary:to-decimal "11"))))

(test trinary-100-is-decimal-9 (is (equal 9 (trinary:to-decimal "100"))))

(test trinary-112-is-decimal-14 (is (equal 14 (trinary:to-decimal "112"))))

(test trinary-222-is-decimal-26 (is (equal 26 (trinary:to-decimal "222"))))

(test trinary-1122000120-is-decimal-32091
 (is (equal 32091 (trinary:to-decimal "1122000120"))))

(test invalid-input-is-decimal-0 (is (equal 0 (trinary:to-decimal "carrot"))))

(test invalid-input-with-digits-is-decimal-0
 (is (equal 0 (trinary:to-decimal "0a1b2c"))))

(defun run-tests (&optional (test-or-suite 'trinary-suite))
  "Provides human readable results of test run. Default to entire suite."
  (run! test-or-suite))
