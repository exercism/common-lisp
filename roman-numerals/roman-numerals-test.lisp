(ql:quickload "lisp-unit")

(defpackage #:roman-test
  (:use #:cl #:lisp-unit))

(load "roman")

(in-package #:roman-test)

(define-test test-1
  (assert-equal "I" (roman:romanize 1)))

(define-test test-2
  (assert-equal "II" (roman:romanize 2)))

(define-test test-3
  (assert-equal "III" (roman:romanize 3)))

(define-test test-4
  (assert-equal "IV" (roman:romanize 4)))

(define-test test-5
  (assert-equal "V" (roman:romanize 5)))

(define-test test-6
  (assert-equal "VI" (roman:romanize 6)))

(define-test test-9
  (assert-equal "IX" (roman:romanize 9)))

(define-test test-27
  (assert-equal "XXVII" (roman:romanize 27)))

(define-test test-48
  (assert-equal "XLVIII" (roman:romanize 48)))

(define-test test-59
  (assert-equal "LIX" (roman:romanize 59)))

(define-test test-93
  (assert-equal "XCIII" (roman:romanize 93)))

(define-test test-141
  (assert-equal "CXLI" (roman:romanize 141)))

(define-test test-163
  (assert-equal "CLXIII" (roman:romanize 163)))

(define-test test-402
  (assert-equal "CDII" (roman:romanize 402)))

(define-test test-575
  (assert-equal "DLXXV" (roman:romanize 575)))

(define-test test-911
  (assert-equal "CMXI" (roman:romanize 911)))

(define-test test-1024
  (assert-equal "MXXIV" (roman:romanize 1024)))

(define-test test-3000
  (assert-equal "MMM" (roman:romanize 3000)))

(let ((*print-errors* t)
      (*print-failures* t))
  (run-tests :all :roman-test))
