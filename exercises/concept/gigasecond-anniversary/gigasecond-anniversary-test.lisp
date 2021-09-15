;; Ensures that gigasecond-anniversary.lisp and the testing library are always loaded
(eval-when (:compile-toplevel :load-toplevel :execute)
  (load "gigasecond-anniversary")
  (quicklisp-client:quickload :fiveam))

;; Defines the testing package with symbols from gigasecond-anniversary and FiveAM in scope
;; The `run-tests` function is exported for use by both the user and test-runner
(defpackage :gigasecond-anniversary-test
  (:use :cl :fiveam)
  (:export :run-tests))

;; Enter the testing package
(in-package :gigasecond-anniversary-test)

;; Define and enter a new FiveAM test-suite
(def-suite* gigasecond-anniversary-suite)

(test from-lisp-epoch
 (is (equal '(1931 9 10 1 46 40) (gigasecond-anniversary:from 1900 1 1 0 0 0))))

(test from-unix-epoch
 (is (equal '(2001 9 9 1 46 40) (gigasecond-anniversary:from 1970 1 1 0 0 0))))

(test from-20110425t120000Z
 (is (equal '(2043 1 1 13 46 40) (gigasecond-anniversary:from 2011 4 25 12 0 0))))

(test from-19770613t235959Z
 (is (equal '(2009 2 20 1 46 39) (gigasecond-anniversary:from 1977 6 13 23 59 59))))

(test from-19590719t123030Z
 (is (equal '(1991 3 27 14 17 10) (gigasecond-anniversary:from 1959 7 19 12 30 30))))

(defun run-tests (&optional (test-or-suite 'gigasecond-anniversary-suite))
  "Provides human readable results of test run. Default to entire suite."
  (run! test-or-suite))
