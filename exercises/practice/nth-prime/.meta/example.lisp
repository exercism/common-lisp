(defpackage :nth-prime
  (:use :cl)
  (:export :find-prime))

(in-package :nth-prime)

(defun not-prime-p (number)
  (loop for x from 3 to (isqrt number)
    when (zerop (mod number x)) return t))

(defun find-prime (number)
  (when (plusp number)
    (if (= number 1)
      2
      (loop for x from 3 by 2 with primes = 1
        unless (not-prime-p x) do (incf primes)
        when (= number primes) return x))))
