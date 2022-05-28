;;;; This code works by finding the largest/smallest palindrome and then figures
;;;; out the factors than fall within the max/min limits.  It may look inelegant,
;;;; but it remains fast even when a large min/max range is used, and will not
;;;; overflow the heap.

(defpackage :palindrome-products
  (:use :cl)
  (:export :smallest
           :largest))

(in-package :palindrome-products)

(defun palindromep (number min-factor max-factor)
  (let ((num (write-to-string number)))
    (when (string= num (reverse num))
      (loop for factor from min-factor to max-factor
        when (multiple-value-bind (q m) (floor number factor)
                                  (and (zerop m) (<= min-factor q max-factor)))
        return t))))

(defun factors (palindrome min-factor max-factor)
  (when palindrome
    (loop for factor from min-factor to (isqrt palindrome) with q and m
      do (multiple-value-setq (q m) (floor palindrome factor))
      when (and (zerop m) (<= min-factor q max-factor))
      collect (list factor q))))

(defun smallest (min-factor max-factor)
  (when (>= max-factor min-factor)
    (let ((palindrome (loop for number from (expt min-factor 2) to (expt max-factor 2)
                        when (palindromep number min-factor max-factor)
                        return number)))
      (values palindrome (factors palindrome min-factor max-factor)))))

(defun largest (min-factor max-factor)
  (when (>= max-factor min-factor)
    (let ((palindrome (loop for number from (expt max-factor 2) downto (expt min-factor 2)
                        when (palindromep number min-factor max-factor)
                        return number)))
      (values palindrome (factors palindrome min-factor max-factor)))))
