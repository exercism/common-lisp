(defpackage :queen-attack
  (:use :cl)
  (:export :create
           :attackp
           :queen))

(in-package :queen-attack)

(defstruct queen row column)

(defun create (coordinates)
  (let ((row (cdr (assoc :row coordinates)))
        (column (cdr (assoc :column coordinates))))
    (unless (or (> row 7) (> column 7) (minusp row) (minusp column))
      (make-queen :row row :column column))))

(defun attackp (white-queen black-queen)
  (or (= (queen-row white-queen) (queen-row black-queen))
      (= (queen-column white-queen) (queen-column black-queen))
      (= (abs (- (queen-row white-queen) (queen-row black-queen)))
         (abs (- (queen-column white-queen) (queen-column black-queen))))))
