(ql:quickload "lisp-unit")
#-xlisp-test (load "leap-year")

(defpackage #:leap-test
  (:use #:common-lisp #:lisp-unit))

(in-package #:leap-test)

(define-test vanilla-leap-year
  (assert-true (leap:leap-year-p 1996)))

(define-test any-old-year
  (assert-false (leap:leap-year-p 1997)))

(define-test non-leap-even-year
  (assert-false (leap:leap-year-p 1998)))

(define-test century
  (assert-false (leap:leap-year-p 1900)))

(define-test exceptional-century
  (assert-true (leap:leap-year-p 2400)))

#-xlisp-test
(let ((*print-errors* t)
      (*print-failures* t))
  (run-tests :all :leap-test))
