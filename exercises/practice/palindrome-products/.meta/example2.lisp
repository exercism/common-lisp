;;;; This code works by creating a list of all palindromes and their factors,
;;;; and then filters out all invalid answers.  It's 'Lispier' than example.lisp,
;;;; but it becomes slow when encountering a large min/max range and runs the
;;;; risk of a heap overflow.

(defpackage :palindrome-products
  (:use :cl)
  (:export :smallest
           :largest))

(in-package :palindrome-products)

(defun palindromep (number)
  (let ((num (write-to-string number)))
    (string= num (reverse num))))

(defun palindromes-and-factors (min-factor max-factor)
  (let ((multiples (loop for x from min-factor to max-factor
                     collect (loop for y from min-factor to x
                               collect (list (* x y) x y)) into output
                     finally (return (apply #'append output)))))
    (remove-if-not #'palindromep multiples :key #'car)))

(defun find-answer (pal-list function)
  (let* ((palindrome (apply function (mapcar #'car pal-list)))
         (palindrome-factors (remove palindrome pal-list :key #'car :test #'/=)))
    (values palindrome (mapcar #'reverse (reverse (mapcar #'cdr palindrome-factors))))))

(defun smallest (min-factor max-factor)
  (when (>= max-factor min-factor)
    (find-answer (palindromes-and-factors min-factor max-factor) #'min)))

(defun largest (min-factor max-factor)
  (when (>= max-factor min-factor)
    (find-answer (palindromes-and-factors min-factor max-factor) #'max)))
