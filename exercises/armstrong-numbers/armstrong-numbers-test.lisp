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
    (armstrong-numbers:armstrong-number-p 5)))


(define-test
  there-are-no-2-digit-armstrong-numbers
  (assert-equal
    'NIL
    (armstrong-numbers:armstrong-number-p 10)))


(define-test
  three-digit-number-that-is-an-armstrong-number
  (assert-equal
    T
    (armstrong-numbers:armstrong-number-p 153)))


(define-test
  three-digit-number-that-is-not-an-armstrong-number
  (assert-equal
    'NIL
    (armstrong-numbers:armstrong-number-p 100)))


(define-test
  four-digit-number-that-is-an-armstrong-number
  (assert-equal
    T
    (armstrong-numbers:armstrong-number-p 9474)))


(define-test
  four-digit-number-that-is-not-an-armstrong-number
  (assert-equal
    'NIL
    (armstrong-numbers:armstrong-number-p 9475)))


(define-test
  seven-digit-number-that-is-an-armstrong-number
  (assert-equal
    T
    (armstrong-numbers:armstrong-number-p 9926315)))


(define-test
  seven-digit-number-that-is-not-an-armstrong-number
  (assert-equal
    'NIL
    (armstrong-numbers:armstrong-number-p 9926314)))

#-xlisp-test
(let ((*print-errors* t)
      (*print-failures* t))
  (run-tests :all))
