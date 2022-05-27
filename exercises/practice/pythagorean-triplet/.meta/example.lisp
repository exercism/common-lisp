(defpackage :pythagorean-triplet
  (:use :cl)
  (:export :triplets-with-sum))

(in-package :pythagorean-triplet)

(defun work-triplet (triplet n)
  (let ((third-on-second (/ (third triplet) (second triplet))))
    (list (first triplet) (- n (first triplet) third-on-second) third-on-second)))

(defun triplets-with-sum (n)
  (let* ((unworked-triplets (loop for a from 1 to (floor (* 2 n) 7)
                              collect (list a (* 2 (- n a)) (+ (expt a 2) (expt (- n a) 2)))))
         (filtered (remove-if (lambda (x) (plusp (mod (third x) (second x)))) unworked-triplets)))
    (mapcar (lambda (x) (work-triplet x n)) filtered)))
