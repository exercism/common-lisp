(defpackage :queen-attack
  (:use :cl)
  (:export :valid-position-p
           :attackp))

(in-package :queen-attack)

(defun valid-position-p (coordinates)
  (let ((row (car coordinates))
        (column (cdr coordinates)))
    (not (or (> row 7) (> column 7) (minusp row) (minusp column)))))

(defun attackp (white-queen black-queen)
  (when (and (valid-position-p white-queen) (valid-position-p black-queen))
    (or (= (car white-queen) (car black-queen))
        (= (cdr white-queen) (cdr black-queen))
        (= (abs (- (car white-queen) (car black-queen)))
           (abs (- (cdr white-queen) (cdr black-queen)))))))
