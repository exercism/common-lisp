(defpackage :matching-brackets
  (:use :cl)
  (:export :pairedp))

(in-package :matching-brackets)

(defun pairedp (value)
  (let ((only-brackets (remove-if-not (lambda (c) (find c "{}[]()")) value)))
    (zerop (length (reduce #'eliminate-pairs only-brackets :initial-value '())))))

(defun eliminate-pairs (tracker bracket)
  (cond
    ((not tracker) (cons bracket tracker))
    ((or (and (char= #\( (car tracker)) (char= #\) bracket))
         (and (char= #\{ (car tracker)) (char= #\} bracket))
         (and (char= #\[ (car tracker)) (char= #\] bracket))) (cdr tracker))
    (t (cons bracket tracker))))
