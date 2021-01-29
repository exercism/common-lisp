(ql:quickload "lisp-unit")
#-xlisp-test (load "trinary")

(defpackage #:trinary-test
  (:use #:common-lisp #:lisp-unit))

(in-package #:trinary-test)

(define-test trinary-1-is-decimal-1
  (assert-equal 1 (trinary:to-decimal "1")))

(define-test trinary-2-is-decimal-2
  (assert-equal 2 (trinary:to-decimal "2")))

(define-test trinary-10-is-decimal-3
  (assert-equal 3 (trinary:to-decimal "10")))

(define-test trinary-11-is-decimal-4
  (assert-equal 4 (trinary:to-decimal "11")))

(define-test trinary-100-is-decimal-9
  (assert-equal 9 (trinary:to-decimal "100")))

(define-test trinary-112-is-decimal-14
  (assert-equal 14 (trinary:to-decimal "112")))

(define-test trinary-222-is-decimal-26

  (assert-equal 26 (trinary:to-decimal "222")))

(define-test trinary-1122000120-is-decimal-32091
  (assert-equal 32091 (trinary:to-decimal "1122000120")))

(define-test invalid-input-is-decimal-0
  (assert-equal 0 (trinary:to-decimal "carrot")))

(define-test invalid-input-with-digits-is-decimal-0
  (assert-equal 0 (trinary:to-decimal "0a1b2c")))

#-xlisp-test
(let ((*print-errors* t)
      (*print-failures* t))
  (run-tests :all :trinary-test))
