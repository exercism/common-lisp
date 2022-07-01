;; Ensures that luhn.lisp and the testing library are always loaded
(eval-when (:compile-toplevel :load-toplevel :execute)
  (load "luhn")
  (quicklisp-client:quickload :fiveam))

;; Defines the testing package with symbols from luhn and FiveAM in scope
;; The `run-tests` function is exported for use by both the user and test-runner
(defpackage :luhn-test
  (:use :cl :fiveam)
  (:export :run-tests))

;; Enter the testing package
(in-package :luhn-test)

;; Define and enter a new FiveAM test-suite
(def-suite* luhn-suite)

(test single-digit-strings-can-not-be-valid (is (not (luhn:validp "1"))))

(test a-single-zero-is-invalid (is (not (luhn:validp "0"))))

(test a-simple-valid-sin-that-remains-valid-if-reversed
 (is (luhn:validp "059")))

(test a-simple-valid-sin-that-becomes-invalid-if-reversed
 (is (luhn:validp "59")))

(test a-valid-canadian-sin (is (luhn:validp "055 444 285")))

(test invalid-canadian-sin (is (not (luhn:validp "055 444 286"))))

(test invalid-credit-card (is (not (luhn:validp "8273 1232 7352 0569"))))

(test invalid-long-number-with-even-remainder
  (is (not (luhn:validp "1 2345 6789 1234 5678 9012"))))

(test invalid-long-number-with-a-remainder-divisible-by-5
  (is (not (luhn:validp "1 2345 6789 1234 5678 9013"))))

(test valid-number-with-even-number-of-digits
  (is (luhn:validp "095 245 88")))

(test valid-number-with-odd-number-of-spaces
  (is (luhn:validp "234 567 891 234")))

(test valid-strings-with-a-non-digit-added-at-the-end-become-invalid
 (is (not (luhn:validp "059a"))))

(test valid-strings-with-punctuation-included-become-invalid
 (is (not (luhn:validp "055-444-285"))))

(test valid-strings-with-symbols-included-become-invalid
 (is (not (luhn:validp "055# 444$ 285"))))

(test single-zero-with-space-is-invalid (is (not (luhn:validp " 0"))))

(test more-than-a-single-zero-validp (is (luhn:validp "0000 0")))

(test input-digit-9-is-correctly-converted-to-output-digit-9
  (is (luhn:validp "091")))

(test very-long-input-is-valid
  (is (luhn:validp "9999999999 9999999999 9999999999 9999999999")))

(test valid-luhn-with-an-odd-number-of-digits-and-non-zero-first-digit
  (is (luhn:validp "109")))

(test using-ascii-value-for-non-doubled-non-digit-is-not-allowed
  (is (not (luhn:validp "055b 444 285"))))

(test using-ascii-value-for-doubled-non-digit-is-not-allowed
  (is (not (luhn:validp ":9"))))

(test non-numeric-non-space-char-in-the-middle-with-a-sum-that's-divisible-by-10-is-not-allowed
  (is (not (luhn:validp "59%59"))))

(defun run-tests (&optional (test-or-suite 'luhn-suite))
  "Provides human readable results of test run. Default to entire suite."
  (run! test-or-suite))
