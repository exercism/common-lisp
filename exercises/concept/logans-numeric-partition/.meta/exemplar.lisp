(defpackage :logans-numeric-partition
  (:use :cl)
  (:export :categorize-number :partition-numbers))

(in-package :logans-numeric-partition)

(defun categorize-number (acc n)
  (if (oddp n)
      (cons (append (list n) (car acc)) (cdr acc))
      (cons (car acc) (append (list n) (cdr acc)))))

(defun partition-numbers (numbers)
  (reduce #'categorize-number numbers :initial-value '(() . ())))
