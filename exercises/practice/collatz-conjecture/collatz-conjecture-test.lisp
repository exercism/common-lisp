(ql:quickload "lisp-unit")
#-xlisp-test (load "collatz-conjecture")

(defpackage #:collatz-conjecture-test
  (:use #:common-lisp #:lisp-unit))

(in-package #:collatz-conjecture-test)

(define-test steps-for-1
  (assert-equal 0 (collatz-conjecture:collatz 1)))

(define-test steps-for-16
  (assert-equal 4 (collatz-conjecture:collatz 16)))

(define-test steps-for-12
  (assert-equal 9 (collatz-conjecture:collatz 12)))

(define-test steps-for-1000000
  (assert-equal 152 (collatz-conjecture:collatz 1000000)))

(define-test steps-for-0
  (assert-equal NIL (collatz-conjecture:collatz 0)))

(define-test steps-for-negative
  (assert-equal NIL (collatz-conjecture:collatz (- 0 15))))


#-xlisp-test
(let ((*print-errors* t)
      (*print-failures* t))
  (run-tests :all))
