;; Ensures that armstrong-numbers.lisp and the testing library are always loaded
(eval-when (:compile-toplevel :load-toplevel :execute)
  (load "armstrong-numbers")
  (quicklisp-client:quickload :fiveam))

;; Defines the testing package with symbols from armstrong-numbers and FiveAM in scope
;; The `run-tests` function is exported for use by both the user and test-runner
(defpackage :armstrong-numbers-test
  (:use :cl :fiveam)
  (:export :run-tests))

;; Enter the testing package
(in-package :armstrong-numbers-test)

;; Define and enter a new FiveAM test-suite
(def-suite* armstrong-numbers-suite)

(test single-digit-numbers-are-armstrong-numbers
 (is (equal t (armstrong-numbers:armstrong-number-p 5))))

(test there-are-no-2-digit-armstrong-numbers
 (is (equal 'nil (armstrong-numbers:armstrong-number-p 10))))

(test three-digit-number-that-is-an-armstrong-number
 (is (equal t (armstrong-numbers:armstrong-number-p 153))))

(test three-digit-number-that-is-not-an-armstrong-number
 (is (equal 'nil (armstrong-numbers:armstrong-number-p 100))))

(test four-digit-number-that-is-an-armstrong-number
 (is (equal t (armstrong-numbers:armstrong-number-p 9474))))

(test four-digit-number-that-is-not-an-armstrong-number
 (is (equal 'nil (armstrong-numbers:armstrong-number-p 9475))))

(test seven-digit-number-that-is-an-armstrong-number
 (is (equal t (armstrong-numbers:armstrong-number-p 9926315))))

(test seven-digit-number-that-is-not-an-armstrong-number
 (is (equal 'nil (armstrong-numbers:armstrong-number-p 9926314))))

(test armstrong-number-containing-seven-zeroes
 (is (equal t (armstrong-numbers:armstrong-number-p 186709961001538790100634132976990))))

(test the-largest-and-last-armstrong-number
 (is (equal t (armstrong-numbers:armstrong-number-p 115132219018763992565095597973971522401))))

(defun run-tests (&optional (test-or-suite 'armstrong-numbers-suite))
  "Provides human readable results of test run. Default to entire suite."
  (run! test-or-suite))

