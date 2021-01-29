(defpackage #:collatz-conjecture
  (:use #:common-lisp)
  (:export #:collatz))

(in-package #:collatz-conjecture)

(defun collatz-helper (a n)
  (cond ((= n 1)   a)
        ((evenp n) (collatz-helper (+ 1 a) (floor n 2)))
        (T         (collatz-helper (+ 1 a) (+ 1 (* 3 n))))))

(defun collatz (n)
  (when (> n 0)
    (collatz-helper 0 n)))
