(ql:quickload "lisp-unit")
#-xlisp-test (load "luhn")

(defpackage #:luhn-test
  (:use #:cl #:lisp-unit))

(in-package #:luhn-test)

(define-test single-digit-strings-can-not-be-valid
  (assert-false (luhn:validp "1")))

(define-test a-single-zero-is-invalid
  (assert-false (luhn:validp "0")))

(define-test a-simple-valid-sin-that-remains-valid-if-reversed
  (assert-true (luhn:validp "059")))

(define-test a-simple-valid-sin-that-becomes-invalid-if-reversed
  (assert-true (luhn:validp "59")))

(define-test a-valid-canadian-sin
  (assert-true (luhn:validp "055 444 285")))

(define-test invalid-canadian-sin
  (assert-false (luhn:validp "055 444 286")))

(define-test invalid-credit-card
  (assert-false (luhn:validp "8273 1232 7352 0569")))

(define-test valid-strings-with-a-non-digit-included-become-invalid
  (assert-false (luhn:validp "055a 444 285")))

(define-test valid-strings-with-punctuation-included-become-invalid
  (assert-false (luhn:validp "055-444-285")))

(define-test valid-strings-with-symbols-included-become-invalid
  (assert-false (luhn:validp "055£ 444$ 285")))

(define-test single-zero-with-space-is-invalid
  (assert-false (luhn:validp " 0")))

(define-test more-than-a-single-zero-validp
  (assert-true (luhn:validp "0000 0")))

(define-test input-digit-9-is-correctly-converted-to-output-digit-9
  (assert-true (luhn:validp "091")))

(define-test strings-with-non-digits-is-invalid
  (assert-false (luhn:validp ":9")))

#-xlisp-test
(let ((*print-errors* t)
      (*print-failures* t))
  (run-tests :all :luhn-test))
