(defpackage :isogram
  (:use :common-lisp)
  (:export :isogram-p))

(in-package :isogram)

(defun str-list (s)
  (assert (stringp s) (s))
  (coerce (string-upcase s) 'list))

(defun isogram-p-helper (xs)
  (if (null xs) T
    (and (not (and (find (car xs) "ABCDEFGHIJKLMNOPQRSTUVWXYZ")
                   (find (car xs) (cdr xs))))
         (isogram-p-helper (cdr xs)))))

(defun isogram-p (xs)
  (isogram-p-helper (str-list xs)))
