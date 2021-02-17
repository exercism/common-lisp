;; Ensures that phone-number.lisp and the testing library are always loaded
(eval-when (:compile-toplevel :load-toplevel :execute)
  (load "phone-number")
  (quicklisp-client:quickload :fiveam))

;; Defines the testing package with symbols from phone-number and FiveAM in scope
;; The `run-tests` function is exported for use by both the user and test-runner
(defpackage #:phone-number-test
  (:use #:cl #:fiveam)
  (:export #:run-tests))

;; Enter the testing package
(in-package #:phone-number-test)

;; Define and enter a new FiveAM test-suite
(def-suite* phone-number-suite)

(test cleans-number
 (is (equal "1234567890" (phone-number:numbers "(123) 456-7890"))))

(test cleans-number-with-dots
 (is (equal "1234567890" (phone-number:numbers "123.456.7890"))))

(test valid-when-11-digits-and-first-is-1
 (is (equal "1234567890" (phone-number:numbers "11234567890"))))

(test invalid-when-11-digits
 (is (equal "0000000000" (phone-number:numbers "21234567890"))))

(test invalid-when-9-digits
 (is (equal "0000000000" (phone-number:numbers "123456789"))))

(test area-code (is (equal "123" (phone-number:area-code "1234567890"))))

(test pretty-print
 (is (equal "(123) 456-7890" (phone-number:pretty-print "1234567890"))))

(test pretty-print-with-full-us-phone-number
 (is (equal "(123) 456-7890" (phone-number:pretty-print "11234567890"))))

(defun run-tests (&optional (test-or-suite 'phone-number-suite))
  "Provides human readable results of test run. Default to entire suite."
  (run! test-or-suite))
