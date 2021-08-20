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

(test valid-strings-with-a-non-digit-included-become-invalid
 (is (not (luhn:validp "055a 444 285"))))

(test valid-strings-with-punctuation-included-become-invalid
 (is (not (luhn:validp "055-444-285"))))

(test valid-strings-with-symbols-included-become-invalid
 (is (not (luhn:validp "055£ 444$ 285"))))

(test single-zero-with-space-is-invalid (is (not (luhn:validp " 0"))))

(test more-than-a-single-zero-validp (is (luhn:validp "0000 0")))

(test input-digit-9-is-correctly-converted-to-output-digit-9
 (is (luhn:validp "091")))

(test strings-with-non-digits-is-invalid (is (not (luhn:validp ":9"))))

(defun run-tests (&optional (test-or-suite 'luhn-suite))
  "Provides human readable results of test run. Default to entire suite."
  (run! test-or-suite))
