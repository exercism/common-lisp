(defpackage #:squares
  (:use #:cl)
  (:export #:sum-of-squares
           #:square-of-sums
           #:difference))

(in-package #:squares)

(defun square-of-sums (n)
  (expt (* 1/2 n (1+ n)) 2))

(defun sum-of-squares (n)
  (* 1/6 n (1+ n) (1+ (* 2 n))))

(defun difference (n)
  (- (square-of-sums n)
     (sum-of-squares n)))
