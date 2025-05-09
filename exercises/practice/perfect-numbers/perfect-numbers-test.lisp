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

(test smallest-perfect-number-is-classified-correctly
    (let ((number 6))
      (is (string= "perfect" (perfect-numbers:classify number)))))

(test medium-perfect-number-is-classified-correctly
    (let ((number 28))
      (is (string= "perfect" (perfect-numbers:classify number)))))

(test large-perfect-number-is-classified-correctly
    (let ((number 33550336))
      (is (string= "perfect" (perfect-numbers:classify number)))))

(test smallest-abundant-number-is-classified-correctly
    (let ((number 12))
      (is (string= "abundant" (perfect-numbers:classify number)))))

(test medium-abundant-number-is-classified-correctly
    (let ((number 30))
      (is (string= "abundant" (perfect-numbers:classify number)))))

(test large-abundant-number-is-classified-correctly
    (let ((number 33550335))
      (is (string= "abundant" (perfect-numbers:classify number)))))

(test smallest-prime-deficient-number-is-classified-correctly
    (let ((number 2))
      (is (string= "deficient" (perfect-numbers:classify number)))))

(test smallest-non-prime-deficient-number-is-classified-correctly
    (let ((number 4))
      (is (string= "deficient" (perfect-numbers:classify number)))))

(test medium-deficient-number-is-classified-correctly
    (let ((number 32))
      (is (string= "deficient" (perfect-numbers:classify number)))))

(test large-deficient-number-is-classified-correctly
    (let ((number 33550337))
      (is (string= "deficient" (perfect-numbers:classify number)))))

(test edge-case-no-factors-other-than-itself-is-classified-correctly
    (let ((number 1))
      (is (string= "deficient" (perfect-numbers:classify number)))))

(test zero-is-rejected-as-it-is-not-a-positive-integer
    (let ((number 0))
      (is (equal NIL (perfect-numbers:classify number)))))

(test negative-integer-is-rejected-as-it-is-not-a-positive-integer
    (let ((number -1))
      (is (equal NIL (perfect-numbers:classify number)))))

(defun run-tests (&optional (test-or-suite 'perfect-numbers-suite))
  "Provides human readable results of test run. Default to entire suite."
  (run! test-or-suite))
