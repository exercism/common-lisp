(defpackage #:sieve
  (:use #:cl)
  (:export #:primes-to)
  (:documentation "Generates a list of primes up to a given limit."))

(in-package #:sieve)

(defun primes-to (n)
  "List primes up to `n' using sieve of Eratosthenes."
  (loop
     initially (when (< n 2) (return nil))
     with sqrtn = (1+ (isqrt n))
     with sieve = (make-array (1+ n)
                              :element-type 'boolean
                              :initial-element t)
     for maybe from 2 to sqrtn
     when (aref sieve maybe)
     do (loop
           for multi from (* maybe maybe) upto n by maybe
           when (aref sieve multi)
           do (setf (aref sieve multi) nil))
     finally (return
               (loop
                  for index from 2 upto n
                  when (aref sieve index)
                  collect index))))
