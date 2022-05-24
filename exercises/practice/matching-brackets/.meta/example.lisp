(defpackage :matching-brackets
  (:use :cl)
  (:export :pairedp))

(in-package :matching-brackets)

(defparameter +bracket-lookup+ '((#\( . #\)) (#\{ . #\}) (#\[ . #\])))

(defun eliminate-pairs (tracker bracket)
  (let ((match (rassoc bracket +bracket-lookup+)))
    (if (and tracker match (char= (car match) (car tracker)))
      (cdr tracker)
      (cons bracket tracker))))

(defun pairedp (value)
  (let* ((bracket-list (append (mapcar #'car +bracket-lookup+) (mapcar #'cdr +bracket-lookup+)))
         (only-brackets (remove-if-not (lambda (c) (find c bracket-list)) value)))
    (zerop (length (reduce #'eliminate-pairs only-brackets :initial-value '())))))
