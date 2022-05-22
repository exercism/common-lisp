(defpackage :knapsack
  (:use :cl)
  (:export :maximum-value))

(in-package :knapsack)

(defun combine-item (item combo-row)
  (append combo-row (mapcar (lambda (cell) (add-acons item cell)) combo-row)))

(defun add-acons (&rest cells)
  (cons (reduce #'+ cells :key #'car) (reduce #'+ cells :key #'cdr)))

(defun maximum-value (maximum-weight items)
  (let ((compact-items (loop for item in items
                         collect (cons (cdr (assoc :weight item))
                                       (cdr (assoc :value item)))))
        (possible-combos '((0 . 0))))
    (loop for item in compact-items
      do (setf possible-combos (combine-item item possible-combos)))
    (setf possible-combos (remove-if (lambda (x) (> x maximum-weight)) possible-combos :key #'car))
    (reduce #'max possible-combos :key #'cdr)))
