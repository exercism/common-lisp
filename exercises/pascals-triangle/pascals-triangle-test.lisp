(ql:quickload "lisp-unit")
#-xlisp-test (load "pascal")

(defpackage #:pascal-test
  (:use #:common-lisp #:lisp-unit))
(in-package #:pascal-test)

(define-test zero-rows
    (assert-equal '()
                  (pascal:rows 0)))

(define-test single-row
    (assert-equal '((1))
                  (pascal:rows 1)))

(define-test two-rows
    (assert-equal '((1) (1 1))
                  (pascal:rows 2)))

(define-test three-rows
    (assert-equal '((1) (1 1) (1 2 1))
                  (pascal:rows 3)))

(define-test four-rows
    (assert-equal '((1) (1 1) (1 2 1) (1 3 3 1))
                  (pascal:rows 4)))

(define-test negative-rows
    (assert-equal '()
                  (pascal:rows -1)))
#-xlisp-test
(let ((*print-errors* t)
      (*print-failures* t))
  (run-tests :all :pascal-test))
