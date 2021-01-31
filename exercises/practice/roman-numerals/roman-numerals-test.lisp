(ql:quickload "lisp-unit")
#-xlisp-test (load "roman-numerals")

(defpackage #:roman-numerals-test
  (:use #:cl #:lisp-unit))

(in-package #:roman-numerals-test)

(define-test test-1
  (assert-equal "I" (roman-numerals:romanize 1)))

(define-test test-2
  (assert-equal "II" (roman-numerals:romanize 2)))

(define-test test-3
  (assert-equal "III" (roman-numerals:romanize 3)))

(define-test test-4
  (assert-equal "IV" (roman-numerals:romanize 4)))

(define-test test-5
  (assert-equal "V" (roman-numerals:romanize 5)))

(define-test test-6
  (assert-equal "VI" (roman-numerals:romanize 6)))

(define-test test-9
  (assert-equal "IX" (roman-numerals:romanize 9)))

(define-test test-27
  (assert-equal "XXVII" (roman-numerals:romanize 27)))

(define-test test-48
  (assert-equal "XLVIII" (roman-numerals:romanize 48)))

(define-test test-59
  (assert-equal "LIX" (roman-numerals:romanize 59)))

(define-test test-93
  (assert-equal "XCIII" (roman-numerals:romanize 93)))

(define-test test-141
  (assert-equal "CXLI" (roman-numerals:romanize 141)))

(define-test test-163
  (assert-equal "CLXIII" (roman-numerals:romanize 163)))

(define-test test-402
  (assert-equal "CDII" (roman-numerals:romanize 402)))

(define-test test-575
  (assert-equal "DLXXV" (roman-numerals:romanize 575)))

(define-test test-911
  (assert-equal "CMXI" (roman-numerals:romanize 911)))

(define-test test-1024
  (assert-equal "MXXIV" (roman-numerals:romanize 1024)))

(define-test test-3000
  (assert-equal "MMM" (roman-numerals:romanize 3000)))

#-xlisp-test
(let ((*print-errors* t)
      (*print-failures* t))
  (run-tests :all :roman-numerals-test))
