;;; 
;;; armstrong-numbers v1.0.0
;;; 
(ql:quickload "lisp-unit")
#-xlisp-test (load "armstrong-numbers")

(defpackage #:armstrong-numbers-test
  (:use #:common-lisp #:lisp-unit))
(in-package #:armstrong-numbers-test)

(define-test
  single-digit-numbers-are-armstrong-numbers
  (assert-equal
    T
    (armstrong-numbers:isarmstrongnumber 5)))


(define-test
  there-are-no-2-digit-armstrong-numbers
  (assert-equal
    'NIL
    (armstrong-numbers:isarmstrongnumber 10)))


(define-test
  three-digit-number-that-is-an-armstrong-number
  (assert-equal
    T
    (armstrong-numbers:isarmstrongnumber 153)))


(define-test
  three-digit-number-that-is-not-an-armstrong-number
  (assert-equal
    'NIL
    (armstrong-numbers:isarmstrongnumber 100)))


(define-test
  four-digit-number-that-is-an-armstrong-number
  (assert-equal
    T
    (armstrong-numbers:isarmstrongnumber 9474)))


(define-test
  four-digit-number-that-is-not-an-armstrong-number
  (assert-equal
    'NIL
    (armstrong-numbers:isarmstrongnumber 9475)))


(define-test
  seven-digit-number-that-is-an-armstrong-number
  (assert-equal
    T
    (armstrong-numbers:isarmstrongnumber 9926315)))


(define-test
  seven-digit-number-that-is-not-an-armstrong-number
  (assert-equal
    'NIL
    (armstrong-numbers:isarmstrongnumber 9926314)))

#-xlisp-test
(let ((*print-errors* t)
      (*print-failures* t))
  (run-tests :all))
