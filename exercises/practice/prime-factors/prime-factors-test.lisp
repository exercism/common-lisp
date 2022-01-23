;; Ensures that prime-factors.lisp and the testing library are always loaded
(eval-when (:compile-toplevel :load-toplevel :execute)
  (load "prime-factors")
  (quicklisp-client:quickload :fiveam))

;; Defines the testing package with symbols from prime-factors and FiveAM in scope
;; The `run-tests` function is exported for use by both the user and test-runner
(defpackage :prime-factors-test
  (:use :cl :fiveam)
  (:export :run-tests))

;; Enter the testing package
(in-package :prime-factors-test)

;; Define and enter a new FiveAM test-suite
(def-suite* prime-factors-suite)

(test no-factors
  (is (equal '() (prime-factors:factors 1))))

(test prime-number
  (is (equal '(2) (prime-factors:factors 2))))

(test another-prime-number]
  (is (equal '(3) (prime-factors:factors 3))))

(test square-of-a-prime
  (is (equal '(3 3) (prime-factors:factors 9))))

(test product-of-first-prime
  (is (equal '(2 2) (prime-factors:factors 4))))

(test cube-of-a-prime
  (is (equal '(2 2 2) (prime-factors:factors 8))))

(test product-of-second-prime
  (is (equal '(3 3 3) (prime-factors:factors 27))))

(test product-of-third-prime
  (is (equal '(5 5 5 5) (prime-factors:factors 625))))

(test product-of-first-and-second-prime
  (is (equal '(2 3) (prime-factors:factors 6))))

(test product-of-primes-and-non-primes
  (is (equal '(2 2 3) (prime-factors:factors 12))))

(test product-of-primes
  (is (equal '(5 17 23 461) (prime-factors:factors 901255))))

(test factors-include-a-large-prime
  (is (equal '(11 9539 894119) (prime-factors:factors 93819012551))))

(defun run-tests (&optional (test-or-suite 'prime-factors-suite))
  "Provides human readable results of test run. Default to entire suite."
  (run! test-or-suite))
