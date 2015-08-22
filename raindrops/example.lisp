(defpackage #:raindrops
  (:use #:common-lisp)
  (:export #:convert))

(in-package #:raindrops)

(defun convert (n &optional (cases '((3 . "Pling") (5 . "Plang") (7 . "Plong"))))
  (let ((results
         (do* ((cs cases (cdr cs))
               (c (car cs) (car cs))
               (result (list)))
              ((null cs) (reverse result))
           (when (zerop (mod n (car c)))
             (push (cdr c) result)))))
    (if results
        (apply #'concatenate 'string results)
        (write-to-string n))))
