(defpackage #:perfect-numbers
  (:use #:common-lisp)
  (:export #:classify))

(in-package #:perfect-numbers)

(defun divisors (n)
  (remove-if-not (lambda (x) (= 0 (rem n x)))
                 (loop for x from 1 to (floor n 2) collect x)))

(defun classify (n)
  (let ((div-sum (apply #'+ (divisors n))))
    (cond ((< n 1)       (warn "Just defined for natural numbers"))
          ((= n div-sum) "perfect")
          ((< n div-sum) "abundant")
          (T             "deficient"))))
