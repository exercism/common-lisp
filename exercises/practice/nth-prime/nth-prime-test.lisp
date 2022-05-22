;; Ensures that nth-prime.lisp and the testing library are always loaded
(eval-when (:compile-toplevel :load-toplevel :execute)
  (load "nth-prime")
  (quicklisp-client:quickload :fiveam))

;; Defines the testing package with symbols from nth-prime and FiveAM in scope
;; The `run-tests` function is exported for use by both the user and test-runner
(defpackage :nth-prime-test
  (:use :cl :fiveam)
  (:export :run-tests))

;; Enter the testing package
(in-package :nth-prime-test)

;; Define and enter a new FiveAM test-suite
(def-suite* nth-prime-suite)

(test first-prime
    (let ((number 1))
      (is (= 2 (nth-prime:find-prime number)))))

(test second-prime
    (let ((number 2))
      (is (= 3 (nth-prime:find-prime number)))))

(test sixth-prime
    (let ((number 6))
      (is (= 13 (nth-prime:find-prime number)))))

(test big-prime
    (let ((number 10001))
      (is (= 104743 (nth-prime:find-prime number)))))

(test there-is-no-zeroth-prime
    (let ((number 0))
      (is (equal NIL (nth-prime:find-prime number)))))

(defun run-tests (&optional (test-or-suite 'nth-prime-suite))
  "Provides human readable results of test run. Default to entire suite."
  (run! test-or-suite))
