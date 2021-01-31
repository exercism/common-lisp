(ql:quickload "lisp-unit")
#-xlisp-test (load "pascals-triangle")

(defpackage #:pascals-triangle-test
  (:use #:common-lisp #:lisp-unit))
(in-package #:pascals-triangle-test)

(define-test zero-rows
    (assert-equal '()
                  (pascals-triangle:rows 0)))

(define-test single-row
    (assert-equal '((1))
                  (pascals-triangle:rows 1)))

(define-test two-rows
    (assert-equal '((1) (1 1))
                  (pascals-triangle:rows 2)))

(define-test three-rows
    (assert-equal '((1) (1 1) (1 2 1))
                  (pascals-triangle:rows 3)))

(define-test four-rows
    (assert-equal '((1) (1 1) (1 2 1) (1 3 3 1))
                  (pascals-triangle:rows 4)))

(define-test negative-rows
    (assert-equal '()
                  (pascals-triangle:rows -1)))
#-xlisp-test
(let ((*print-errors* t)
      (*print-failures* t))
  (run-tests :all :pascals-triange-test))
