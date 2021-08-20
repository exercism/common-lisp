;; Ensures that perfect-numbers.lisp and the testing library are always loaded
(eval-when (:compile-toplevel :load-toplevel :execute)
  (load "perfect-numbers")
  (quicklisp-client:quickload :fiveam))

;; Defines the testing package with symbols from perfect-numbers and FiveAM in scope
;; The `run-tests` function is exported for use by both the user and test-runner
(defpackage :perfect-numbers-test
  (:use :cl :fiveam)
  (:export :run-tests))

;; Enter the testing package
(in-package :perfect-numbers-test)

;; Define and enter a new FiveAM test-suite
(def-suite* perfect-numbers-suite)

(test smallest-perfect-number
 (is (equal "perfect" (perfect-numbers:classify 6))))

(test medium-perfect-number
 (is (equal "perfect" (perfect-numbers:classify 28))))

(test large-perfect-number
 (is (equal "perfect" (perfect-numbers:classify 33550336))))

(test smallest-abundant-number
 (is (equal "abundant" (perfect-numbers:classify 12))))

(test medium-abundant-number
 (is (equal "abundant" (perfect-numbers:classify 30))))

(test large-abundant-number
 (is (equal "abundant" (perfect-numbers:classify 33550335))))

(test smallest-prime-deficient-number
 (is (equal "deficient" (perfect-numbers:classify 2))))

(test smallest-non-prime-deficient-number
 (is (equal "deficient" (perfect-numbers:classify 1))))

(test medium-deficient-number
 (is (equal "deficient" (perfect-numbers:classify 32))))

(test large-deficient-number
 (is (equal "deficient" (perfect-numbers:classify 33550337))))

(test undefinded-0 (is (equal nil (perfect-numbers:classify 0))))

(test undefined-negative (is (equal nil (perfect-numbers:classify -3))))

(defun run-tests (&optional (test-or-suite 'perfect-numbers-suite))
  "Provides human readable results of test run. Default to entire suite."
  (run! test-or-suite))
