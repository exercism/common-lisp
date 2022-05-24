;; Ensures that sum-of-multiples.lisp and the testing library are always loaded
(eval-when (:compile-toplevel :load-toplevel :execute)
  (load "sum-of-multiples")
  (quicklisp-client:quickload :fiveam))

;; Defines the testing package with symbols from sum-of-multiples and FiveAM in scope
;; The `run-tests` function is exported for use by both the user and test-runner
(defpackage :sum-of-multiples-test
  (:use :cl :fiveam)
  (:export :run-tests))

;; Enter the testing package
(in-package :sum-of-multiples-test)

;; Define and enter a new FiveAM test-suite
(def-suite* sum-of-multiples-suite)

(test no-multiples-within-limit
    (let ((factors (list 3 5))
          (limit 1))
      (is (= 0 (sum-of-multiples:sum factors limit)))))

(test one-factor-has-multiples-within-limit
    (let ((factors (list 3 5))
          (limit 4))
      (is (= 3 (sum-of-multiples:sum factors limit)))))

(test more-than-one-multiple-within-limit
    (let ((factors (list 3))
          (limit 7))
      (is (= 9 (sum-of-multiples:sum factors limit)))))

(test more-than-one-factor-with-multiples-within-limit
    (let ((factors (list 3 5))
          (limit 10))
      (is (= 23 (sum-of-multiples:sum factors limit)))))

(test each-multiple-is-only-counted-once
    (let ((factors (list 3 5))
          (limit 100))
      (is (= 2318 (sum-of-multiples:sum factors limit)))))

(test a-much-larger-limit
    (let ((factors (list 3 5))
          (limit 1000))
      (is (= 233168 (sum-of-multiples:sum factors limit)))))

(test three-factors
    (let ((factors (list 7 13 17))
          (limit 20))
      (is (= 51 (sum-of-multiples:sum factors limit)))))

(test factors-not-relatively-prime
    (let ((factors (list 4 6))
          (limit 15))
      (is (= 30 (sum-of-multiples:sum factors limit)))))

(test some-pairs-of-factors-relatively-prime-and-some-not
    (let ((factors (list 5 6 8))
          (limit 150))
      (is (= 4419 (sum-of-multiples:sum factors limit)))))

(test one-factor-is-a-multiple-of-another
    (let ((factors (list 5 25))
          (limit 51))
      (is (= 275 (sum-of-multiples:sum factors limit)))))

(test much-larger-factors
    (let ((factors (list 43 47))
          (limit 10000))
      (is (= 2203160 (sum-of-multiples:sum factors limit)))))

(test all-numbers-are-multiples-of-1
    (let ((factors (list 1))
          (limit 100))
      (is (= 4950 (sum-of-multiples:sum factors limit)))))

(test no-factors-means-an-empty-sum
    (let ((factors (list ))
          (limit 10000))
      (is (= 0 (sum-of-multiples:sum factors limit)))))

(test the-only-multiple-of-0-is-0
    (let ((factors (list 0))
          (limit 1))
      (is (= 0 (sum-of-multiples:sum factors limit)))))

(test the-factor-0-does-not-affect-the-sum-of-multiples-of-other-factors
    (let ((factors (list 3 0))
          (limit 4))
      (is (= 3 (sum-of-multiples:sum factors limit)))))

(test solutions-using-include-exclude-must-extend-to-cardinality-greater-than-3
    (let ((factors (list 2 3 5 7 11))
          (limit 10000))
      (is (= 39614537 (sum-of-multiples:sum factors limit)))))

(defun run-tests (&optional (test-or-suite 'sum-of-multiples-suite))
  "Provides human readable results of test run. Default to entire suite."
  (run! test-or-suite))
