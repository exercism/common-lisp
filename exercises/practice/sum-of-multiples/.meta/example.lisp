(defpackage :sum-of-multiples
  (:use :cl)
  (:export :sum))

(in-package :sum-of-multiples)

(defun sum (factors limit)
 (let ((cleaned-factors (remove-if-not #'plusp factors)))
   (apply #'+ (remove-duplicates (multiples-of cleaned-factors limit)))))

(defun multiples-of (factors limit)
  (when factors
   (let ((factor (first factors))
         (remaining (rest factors)))
     (loop for x from factor below limit by factor
       collect x into output
       finally (return (append output (multiples-of remaining limit)))))))
