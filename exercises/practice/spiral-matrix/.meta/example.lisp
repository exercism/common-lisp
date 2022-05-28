(defpackage :spiral-matrix
  (:use :cl)
  (:export :spiral-matrix))

(in-package :spiral-matrix)

(defun turnp (matrix index delta size)
  (let ((look-ahead (mapcar #'+ index delta)))
    (or (minusp (second look-ahead))
        (= size (first look-ahead))
        (= size (second look-ahead))
        (apply #'aref matrix look-ahead))))

(defun spiral-matrix (size)
  (when (plusp size)
    (let ((cycler '#0=((0 1) (1 0) (0 -1) (-1 0) . #0#))
          (matrix (make-array (list size size) :initial-element nil))
          (index '(0 0)))
      (loop for i from 1 to (array-total-size matrix) with delta = (pop cycler)
        do (setf (apply #'aref matrix index) i)
        when (turnp matrix index delta size) do (setf delta (pop cycler))
        do (setf index (mapcar #'+ index delta))
        finally (return matrix)))))
