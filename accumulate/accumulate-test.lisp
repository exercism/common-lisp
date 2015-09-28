(ql:quickload "lisp-unit")

(defpackage #:accumulate-test
  (:use #:common-lisp #:lisp-unit))

#-xlisp-test (load "accumulate")

(in-package #:accumulate-test)

(defun square (x) (* x x))

(define-test empty-accumulation
  (assert-equal '() (accumulate:accumulate #'square '())))

(define-test accumulate-squares
  (assert-equal '(1 4 9)
                (accumulate:accumulate
                 #'square
                 '(1 2 3))))

(define-test accumulate-upcases
  (assert-equal '("HELLO" "WORLD")
                (accumulate:accumulate
                 #'string-upcase
                 '("hello" "world"))))

(define-test accumulate-reversed-strings
  (assert-equal '("eht" "kciuq" "nworb" "xof" "cte")
                (accumulate:accumulate
                 #'reverse
                 '("the" "quick" "brown" "fox" "etc"))))

#-xlisp-test
(let ((*print-errors* t)
      (*print-failures* t))
  (run-tests :all :accumulate-test))
