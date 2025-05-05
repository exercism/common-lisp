;; Ensures that leap.lisp and the testing library are always loaded
(eval-when (:compile-toplevel :load-toplevel :execute)
  (load "leap")
  (quicklisp-client:quickload :fiveam))

;; Defines the testing package with symbols from leap and FiveAM in scope
;; The `run-tests` function is exported for use by both the user and test-runner
(defpackage :leap-test
  (:use :cl :fiveam)
  (:export :run-tests))

;; Enter the testing package
(in-package :leap-test)

;; Define and enter a new FiveAM test-suite
(def-suite* leap-suite)

(test year-not-divisible-by-4-is-common-year
    (let ((year 2015))
      (is-false (leap:leap-year-p year))))

(test year-divisible-by-2-not-divisible-by-4-is-common-year
    (let ((year 1970))
      (is-false (leap:leap-year-p year))))

(test year-divisible-by-4-not-divisible-by-100-is-leap-year
    (let ((year 1996))
      (is-true (leap:leap-year-p year))))

(test year-divisible-by-4-and-5-is-still-a-leap-year
    (let ((year 1960))
      (is-true (leap:leap-year-p year))))

(test year-divisible-by-100-not-divisible-by-400-is-common-year
    (let ((year 2100))
      (is-false (leap:leap-year-p year))))

(test year-divisible-by-100-but-not-by-3-is-still-not-a-leap-year
    (let ((year 1900))
      (is-false (leap:leap-year-p year))))

(test year-divisible-by-400-is-leap-year
    (let ((year 2000))
      (is-true (leap:leap-year-p year))))

(test year-divisible-by-400-but-not-by-125-is-still-a-leap-year
    (let ((year 2400))
      (is-true (leap:leap-year-p year))))

(test year-divisible-by-200-not-divisible-by-400-is-common-year
    (let ((year 1800))
      (is-false (leap:leap-year-p year))))

(defun run-tests (&optional (test-or-suite 'leap-suite))
  "Provides human readable results of test run. Default to entire suite."
  (run! test-or-suite))
