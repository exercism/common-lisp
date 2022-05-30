#|
For each side a, so long as 0 < a < n / 3.414, the math works like this:

a^2 + b^2 = c^2
a + b + c = n

where a is the shortest side
      b is the mid-length side
      c is the hypotenuse
      n is the perimeter

b^2 = c^2 - a^2
b = n - a - c

b^2 = c^2 - a^2
b^2 = n^2 - 2an + a^2 - 2nc + c^2 + 2ac

c^2 - a^2 = n^2 - 2an + a^2 - 2nc + c^2 + 2ac

n^2 - 2an + 2a^2 - 2nc + 2ac = 0

(n - a)^2 + a^2 - 2c(n - a) = 0

2c(n - a) = a^2 + (n - a)^2

Therefore c = (a^2 + (n - a)^2) / 2(n - a)

But we also want c to be a a whole number

Therefore numerator   = a^2 + (n - a)^2
          denominator = 2(n - a)

If numerator % denominator == 0 then c is a whole number, else go to next a

Given that c is a whole number, and we know both a and n, we can now calculate b:

a + b + c = n

Therefore b = n - a - c

Collect a, b and c into a list and go to next a
|#

(defpackage :pythagorean-triplet
  (:use :cl)
  (:export :triplets-with-sum))

(in-package :pythagorean-triplet)

(defparameter +right-isoceles-perimeter-ratio+ 3.414) ; approx 1 + 1 + 2^(1/2)

(defun triplets-with-sum (n)
  (loop for a from 1 to (floor n +right-isoceles-perimeter-ratio+) with c and modulo
    do (multiple-value-setq (c modulo) (floor (+ (expt a 2) (expt (- n a) 2)) (* 2 (- n a))))
    when (zerop modulo)
    collect (list a (- n a c) c)))
