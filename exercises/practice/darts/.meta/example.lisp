(defpackage :darts
  (:use :cl)
  (:export :score))

(in-package :darts)

(defun score (x y)
  (let ((distance (sqrt (+ (* x x) (* y y)))))
    (cond
      ((> distance 10) 0)
      ((> distance 5) 1)
      ((> distance 1) 5)
      (t 10))))
