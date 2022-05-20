(defpackage :sum-of-multiples
  (:use :cl)
  (:export :sum))

(in-package :sum-of-multiples)

(defun sum (factors limit)
  (loop for factor in (remove-if-not #'plusp factors)
    collect (loop for x from factor below limit by factor collect x) into output
    finally (return (apply #'+ (remove-duplicates (reduce #'append output))))))
