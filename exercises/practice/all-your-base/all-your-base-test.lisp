(ql:quickload "lisp-unit")
#-xlisp-test (load "all-your-base")

(defpackage #:all-your-base-test
  (:use #:common-lisp #:lisp-unit))

(in-package #:all-your-base-test)

(define-test single-bit-one-to-decimal
  (assert-equal '( 1 )
                (all-your-base:rebase '( 1 ) 2 10)))

(define-test binary-to-single-decimal
  (assert-equal '( 5 )
                (all-your-base:rebase '( 1 0 1 ) 2 10)))

(define-test single-decimal-to-binary
  (assert-equal '( 1 0 1 )
                (all-your-base:rebase '( 5 ) 10 2)))

(define-test binary-to-multiple-decimal
  (assert-equal '( 4 2 )
                (all-your-base:rebase '( 1 0 1 0 1 0 ) 2 10)))

(define-test decimal-to-binary
  (assert-equal '( 1 0 1 0 1 0 )
                (all-your-base:rebase '( 4 2 ) 10 2)))

(define-test trinary-to-hexadecimal
  (assert-equal '( 2 10 )
                (all-your-base:rebase '( 1 1 2 0 ) 3 16)))

(define-test hexadecimal-to-trinary
  (assert-equal '( 1 1 2 0 )
                (all-your-base:rebase '( 2 10 ) 16 3)))

(define-test number-15-bit-integer
  (assert-equal '( 6 10 45 )
                (all-your-base:rebase '( 3 46 60 ) 97 73)))

(define-test empty-list
  (assert-equal '( 0 )
                (all-your-base:rebase '() 2 10)))

(define-test single-zero
  (assert-equal '( 0 )
                (all-your-base:rebase '( 0 ) 10 2)))

(define-test multiple-zeros
  (assert-equal '( 0 )
                (all-your-base:rebase '( 0 0 0 ) 10 2)))

(define-test leading-zeros
  (assert-equal '( 4 2 )
                (all-your-base:rebase '( 0 6 0 ) 7 10)))

(define-test input-base-is-one
  (assert-false (all-your-base:rebase '( 0 ) 1 10)))

(define-test input-base-is-zero
  (assert-false (all-your-base:rebase '() 0 10)))

(define-test input-base-is-negative
  (assert-false (all-your-base:rebase '( 1 ) -2 10)))

(define-test negative-digit
  (assert-false (all-your-base:rebase '( 1 -1 1 0 1 0 ) 2 10)))

(define-test invalid-positive-digit
  (assert-false (all-your-base:rebase '( 1 2 1 0 1 0 ) 2 10)))

(define-test output-base-is-one
  (assert-false (all-your-base:rebase '( 1 0 1 0 1 0 ) 2 1)))

(define-test output-base-is-zero
  (assert-false (all-your-base:rebase '( 7 ) 10 0)))

(define-test output-base-is-negative
  (assert-false (all-your-base:rebase '( 1 ) 2 -7)))

(define-test both-bases-are-negative
  (assert-false (all-your-base:rebase '( 1 ) -2 -7)))


#-xlisp-test
(let ((*print-errors* t)
      (*print-failures* t))
  (run-tests :all :all-your-base-test))
