(defpackage :flatten-array
  (:use :cl)
  (:export :flatten))

(in-package :flatten-array)

(defun make-flat (nested flattened-list)
  (if (endp nested)
    flattened-list
    (let ((item (car nested))
          (remains (cdr nested)))
      (if (atom item)
        (cons item (make-flat remains flattened-list))
        (make-flat item (make-flat remains flattened-list))))))

(defun flatten (nested)
  (remove-if #'null (make-flat nested '())))
