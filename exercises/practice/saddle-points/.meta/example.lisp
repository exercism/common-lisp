(defpackage :saddle-points
  (:use :cl)
  (:export :saddle-points))

(in-package :saddle-points)

(defun saddle-points (matrix)
  (unless (equal (array-dimensions matrix) '(1 0))
    (let* ((rows (get-rows-or-columns matrix 0))
           (columns (get-rows-or-columns matrix 1))
           (max-rows (mapcar (lambda (row) (apply #'max row)) rows))
           (min-columns (mapcar (lambda (col) (apply #'min col)) columns)))
      (loop for r in max-rows and i from 1 with saddle-point-list = '()
        do (loop for c in min-columns and j from 1
             when (= r c)
             do (push (list i j) saddle-point-list))
        finally (return saddle-point-list)))))

(defun get-rows-or-columns (matrix dimension)
  (loop for i from 0 below (array-dimension matrix dimension)
    collect (loop for j from 0 below (array-dimension matrix (abs (1- dimension)))
              if (zerop dimension) collect (aref matrix i j)
              else collect (aref matrix j i))))
