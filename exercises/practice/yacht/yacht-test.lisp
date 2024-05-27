;; Ensures that yacht.lisp and the testing library are always loaded
(eval-when (:compile-toplevel :load-toplevel :execute)
  (load "yacht")
  (quicklisp-client:quickload :fiveam))

;; Defines the testing package with symbols from yacht and FiveAM in scope
;; The `run-tests` function is exported for use by both the user and test-runner
(defpackage :yacht-test
  (:use :cl :fiveam)
  (:export :run-tests))

;; Enter the testing package
(in-package :yacht-test)

;; Define and enter a new FiveAM test-suite
(def-suite* yacht-suite)

(test test-1 (is (equal 50 (yacht:score '(5 5 5 5 5) :yacht))))

(test test-2 (is (equal 0 (yacht:score '(1 3 3 2 5) :yacht))))

(test test-3 (is (equal 3 (yacht:score '(1 1 1 3 5) :ones))))

(test test-4 (is (equal 3 (yacht:score '(3 1 1 5 1) :ones))))

(test test-5 (is (equal 0 (yacht:score '(4 3 6 5 5) :ones))))

(test test-6 (is (equal 2 (yacht:score '(2 3 4 5 6) :twos))))

(test test-7 (is (equal 8 (yacht:score '(1 4 1 4 1) :fours))))

(test test-8 (is (equal 15 (yacht:score '(3 3 3 3 3) :threes))))

(test test-9 (is (equal 0 (yacht:score '(3 3 3 3 3) :fives))))

(test test-10 (is (equal 10 (yacht:score '(1 5 3 5 3) :fives))))

(test test-11 (is (equal 6 (yacht:score '(2 3 4 5 6) :sixes))))

(test test-12 (is (equal 16 (yacht:score '(2 2 4 4 4) :full-house))))

(test test-13 (is (equal 19 (yacht:score '(5 3 3 5 3) :full-house))))

(test test-14 (is (equal 0 (yacht:score '(2 2 4 4 5) :full-house))))

(test test-15 (is (equal 0 (yacht:score '(1 4 4 4 4) :full-house))))

(test test-16 (is (equal 0 (yacht:score '(2 2 2 2 2) :full-house))))

(test test-17 (is (equal 24 (yacht:score '(6 6 4 6 6) :four-of-a-kind))))

(test test-18 (is (equal 12 (yacht:score '(3 3 3 3 3) :four-of-a-kind))))

(test test-19 (is (equal 0 (yacht:score '(3 3 3 5 5) :four-of-a-kind))))

(test test-20 (is (equal 30 (yacht:score '(3 5 4 1 2) :little-straight))))

(test test-21 (is (equal 0 (yacht:score '(1 2 3 4 5) :big-straight))))

(test test-22 (is (equal 0 (yacht:score '(1 1 2 3 4) :little-straight))))

(test test-23 (is (equal 0 (yacht:score '(1 2 3 4 6) :little-straight))))

(test test-24 (is (equal 0 (yacht:score '(1 1 3 4 5) :little-straight))))

(test test-25 (is (equal 30 (yacht:score '(4 6 2 5 3) :big-straight))))

(test test-26 (is (equal 0 (yacht:score '(6 5 4 3 2) :little-straight))))

(test test-27 (is (equal 0 (yacht:score '(6 5 4 3 1) :big-straight))))

(test test-28 (is (equal 23 (yacht:score '(3 3 5 6 6) :choice))))

(test test-29 (is (equal 10 (yacht:score '(2 2 2 2 2) :choice))))

(defun run-tests (&optional (test-or-suite 'yacht-suite))
  "Provides human readable results of test run. Default to entire suite."
  (run! test-or-suite))
