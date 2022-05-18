(defpackage :matrix
  (:use :cl)
  (:export :row
           :column))

(in-package :matrix)

(defun row (input-array index)
  (loop for i from 0 below (array-dimension input-array 1)
    collect (aref input-array (1- index) i)))

(defun column (input-array index)
  (loop for i from 0 below (array-dimension input-array 0)
    collect (aref input-array i (1- index))))
