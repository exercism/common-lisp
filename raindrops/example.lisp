(defpackage #:raindrops
  (:use #:common-lisp)
  (:export #:convert))

(in-package #:raindrops)

(defun factor (n)
  "Return a list of factors of n."
  (when (> n 1)
    (loop with max-d = (isqrt n)
       for d = 2 then (if (evenp d) (+ d 1) (+ d 2)) do
         (cond ((> d max-d) (return (list n))) ; n is prime
               ((zerop (rem n d)) (return (cons d (factor (truncate n d)))))))))

(defun convert (n)
  (let ((drops "")
        (factors (remove-if-not #'(lambda (v)
                                    (and (>= v 3) (<= v 7)))
                                (factor n))))
    (if (not (null factors))
        (progn
          (when (member 3 factors)
            (setf drops (concatenate 'string drops "Pling")))
          (when (member 5 factors)
            (setf drops (concatenate 'string drops "Plang")))
          (when (member 7 factors)
            (setf drops (concatenate 'string drops "Plong"))))
        (setf drops (concatenate 'string (write-to-string n))))
    drops))
