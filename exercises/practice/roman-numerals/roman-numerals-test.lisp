;; Ensures that roman-numerals.lisp and the testing library are always loaded
(eval-when (:compile-toplevel :load-toplevel :execute)
  (load "roman-numerals")
  (quicklisp-client:quickload :fiveam))

;; Defines the testing package with symbols from roman-numerals and FiveAM in scope
;; The `run-tests` function is exported for use by both the user and test-runner
(defpackage :roman-numerals-test
  (:use :cl :fiveam)
  (:export :run-tests))

;; Enter the testing package
(in-package :roman-numerals-test)

;; Define and enter a new FiveAM test-suite
(def-suite* roman-numerals-suite)

(test test-1
  (is (string= "I" (roman-numerals:romanize 1))))

(test test-2
  (is (string= "II" (roman-numerals:romanize 2))))

(test test-3
  (is (string= "III" (roman-numerals:romanize 3))))

(test test-4
  (is (string= "IV" (roman-numerals:romanize 4))))

(test test-5
  (is (string= "V" (roman-numerals:romanize 5))))

(test test-6
  (is (string= "VI" (roman-numerals:romanize 6))))

(test test-9
  (is (string= "IX" (roman-numerals:romanize 9))))

(test test-16
  (is (string= "XVI" (roman-numerals:romanize 16))))

(test test-27
  (is (string= "XXVII" (roman-numerals:romanize 27))))

(test test-48
  (is (string= "XLVIII" (roman-numerals:romanize 48))))

(test test-49
  (is (string= "XLIX" (roman-numerals:romanize 49))))

(test test-59
  (is (string= "LIX" (roman-numerals:romanize 59))))

(test test-66
  (is (string= "LXVI" (roman-numerals:romanize 66))))

(test test-93
  (is (string= "XCIII" (roman-numerals:romanize 93))))

(test test-141
  (is (string= "CXLI" (roman-numerals:romanize 141))))

(test test-163
  (is (string= "CLXIII" (roman-numerals:romanize 163))))

(test test-166
  (is (string= "CLXVI" (roman-numerals:romanize 166))))

(test test-402
  (is (string= "CDII" (roman-numerals:romanize 402))))

(test test-575
  (is (string= "DLXXV" (roman-numerals:romanize 575))))

(test test-666
  (is (string= "DCLXVI" (roman-numerals:romanize 666))))

(test test-911
  (is (string= "CMXI" (roman-numerals:romanize 911))))

(test test-1024
  (is (string= "MXXIV" (roman-numerals:romanize 1024))))

(test test-1666
  (is (string= "MDCLXVI" (roman-numerals:romanize 1666))))

(test test-3000
  (is (string= "MMM" (roman-numerals:romanize 3000))))

(test test-3001
  (is (string= "MMMI" (roman-numerals:romanize 3001))))

(test test-3999
  (is (string= "MMMCMXCIX" (roman-numerals:romanize 3999))))

(defun run-tests (&optional (test-or-suite 'roman-numerals-suite))
  "Provides human readable results of test run. Default to entire suite."
  (run! test-or-suite))

