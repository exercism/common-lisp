(defpackage :flatten-array
  (:use :cl)
  (:export :flatten))

(in-package :flatten-array)

(defun flatten (nested)
  (remove nil
          (reduce #'(lambda (acc item)
                      (append acc (if (atom item) (list item) (flatten item))))
                  nested :initial-value (list))))
