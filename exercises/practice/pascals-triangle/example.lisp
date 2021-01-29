(defpackage #:pascal
  (:use #:common-lisp)
  (:export #:rows))

(in-package #:pascal)

(defun fact (n)
  (loop for i from 0 to n
        for fact = 1 then (* fact i)
        finally (return fact)))

(defun choose (n r)
  (/ (fact n)
     (* (fact r) (fact (- n r)))))

(defun rows (n)
  (if (> n 0)
      (loop for i from 0 to (1- n)
               collect (loop for j from 0 to i
                             collect (choose i j)))
      '()))
