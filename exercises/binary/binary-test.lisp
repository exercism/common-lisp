(ql:quickload "lisp-unit")
#-xlisp-test (load "binary")

(defpackage #:binary-test
  (:use #:common-lisp #:lisp-unit))

(in-package #:binary-test)

(define-test binary-1-is-decimal-1
  (assert-equal 1 (binary:to-decimal "1")))

(define-test binary-10-is-decimal-2
  (assert-equal 2 (binary:to-decimal "10")))

(define-test binary-11-is-decimal-3
  (assert-equal 3 (binary:to-decimal "11")))

(define-test binary-100-is-decimal-4
  (assert-equal 4 (binary:to-decimal "100")))

(define-test binary-1001-is-decimal-9
  (assert-equal 9 (binary:to-decimal "1001")))

(define-test binary-11010-is-decimal-26
  (assert-equal 26 (binary:to-decimal "11010")))

(define-test binary-10001101000-is-decimal-1128
  (assert-equal 1128 (binary:to-decimal "10001101000")))

(define-test invalid-binary-is-decimal-0
  (assert-equal 0 (binary:to-decimal "carrot")))

(define-test invalid-characters-at-beginning
  (assert-equal 2 (binary:to-decimal "a10")))

(define-test invalid-characters-at-end
  (assert-equal 2 (binary:to-decimal "10a")))

(define-test invalid-characters-in-middle
  (assert-equal 2 (binary:to-decimal "1a0")))

(define-test invalid-digits
  (assert-equal 0 (binary:to-decimal "23")))

#-xlisp-test
(let ((*print-errors* t)
      (*print-failures* t))
  (run-tests :all))
