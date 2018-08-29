(ql:quickload "lisp-unit")
#-xlisp-test (load "squares")

(defpackage #:squares-test
  (:use #:cl #:lisp-unit))

(in-package #:squares-test)

(define-test square-of-sum-to-5
  (assert-equal 225 (squares:square-of-sum 5)))
(define-test sum-of-squares-to-5
  (assert-equal 55 (squares:sum-of-squares 5)))
(define-test difference-of-sums-to-5
  (assert-equal 170 (squares:difference 5)))

(define-test square-of-sum-to-10
  (assert-equal 3025 (squares:square-of-sum 10)))
(define-test sum-of-squares-to-10
  (assert-equal 385 (squares:sum-of-squares 10)))
(define-test difference-of-sums-to-10
  (assert-equal 2640 (squares:difference 10)))

(define-test square-of-sum-to-100
  (assert-equal 25502500 (squares:square-of-sum 100)))
(define-test sum-of-squares-to-100
  (assert-equal 338350 (squares:sum-of-squares 100)))
(define-test difference-of-sums-to-100
  (assert-equal 25164150 (squares:difference 100)))

#-xlisp-test
(let ((*print-errors* t)
      (*print-failures* t))
  (run-tests :all :squares-test))
