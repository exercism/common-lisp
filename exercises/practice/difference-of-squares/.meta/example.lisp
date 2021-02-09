(defpackage #:difference-of-squares
  (:use #:cl)
  (:export #:sum-of-squares
           #:square-of-sum
           #:difference))

(in-package #:difference-of-squares)

(defun square-of-sum (n)
  (expt (* 1/2 n (1+ n)) 2))

(defun sum-of-squares (n)
  (* 1/6 n (1+ n) (1+ (* 2 n))))

(defun difference (n)
  (- (square-of-sum n)
     (sum-of-squares n)))
