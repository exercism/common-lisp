(defpackage :prime-factors
  (:use :cl)
  (:export :factors-of)
  (:documentation "Generates a list of prime factors of given integer."))

(in-package :prime-factors)

(defun make-wheel-2-3-5-7 ()
  "Returns function generating prime-ish numbers."
  (let ((incr '#0=(2 4 2 4 6 2 6 4 2 4 6 6
                     2 6 4 2 6 4 6 8 4 2 4
                     2 4 8 6 4 6 2 4 6 2 6
                     6 4 2 4 6 2 6 4 2 4 2
                     10 2 10 . #0#))
        (next '(2 3 5 7 11))
        (last nil))
    (lambda ()
      (if next
          (setf last (pop next))
          (incf last (pop incr))))))

(defun factors-of (number)
  "List prime factors of `number'.

Based on algorithm A from TAoCP 4.3.4 but with a larger wheel."
  (declare (type integer number))
  (loop
     with factors = ()
     initially (unless (< 1 number) (loop-finish))
     with dividend = number
     with next-divisor = (make-wheel-2-3-5-7)
     with divisor = (funcall next-divisor)
     do
       (multiple-value-bind (quotient remainder)
           (floor dividend divisor)
         (cond ((zerop remainder)
                (push divisor factors)
                (if (= 1 quotient)
                    (loop-finish)
                    (setq dividend quotient)))
               ((> quotient divisor)
                (setq divisor (funcall next-divisor)))
               (t
                (push dividend factors)
                (loop-finish))))
     finally
       (return (nreverse factors))))
