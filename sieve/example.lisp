(defpackage #:sieve
  (:use #:cl)
  (:export #:primes-to)
  (:documentation "Generates a list of primes up to a given limit."))

(in-package #:sieve)

(defun primes-to (n)
  "List primes below `n' using sieve of Eratosthenes."
  (loop
     initially (when (< n 3) (return nil))
     with sqrtn = (1+ (isqrt n))
     with sieve = (make-array n
                              :element-type 'boolean
                              :initial-element t)
     for maybe from 2 to sqrtn
     when (aref sieve maybe)
     do
       (loop
          for multi from (* maybe maybe) below n by maybe
          when (aref sieve multi)
          do (setf (aref sieve multi) nil))
     finally (return
               (loop
                  for index from 2 below n
                  when (aref sieve index)
                  collect index))))
