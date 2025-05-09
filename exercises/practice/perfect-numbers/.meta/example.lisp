(defpackage :perfect-numbers
  (:use :common-lisp)
  (:export :classify))

(in-package :perfect-numbers)

(defun divisors (number)
  (remove-if-not (lambda (x) (= 0 (rem number x)))
                 (loop for x from 1 to (floor number 2) collect x)))

(defun classify (number)
  (if (> number 0)
      (let ((div-sum (reduce #'+ (divisors number))))
        (cond ((= number div-sum) "perfect")
              ((< number div-sum) "abundant")
              (T             "deficient")))
      (warn "Just defined for natural numbers")))
