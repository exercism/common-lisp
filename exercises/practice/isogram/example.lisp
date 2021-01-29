(defpackage #:isogram
  (:use #:common-lisp)
  (:export #:is-isogram))

(in-package #:isogram)

(defun str-list (s)
  (assert (stringp s) (s))
  (coerce (string-upcase s) 'list))

(defun is-isogram-helper (xs)
  (if (null xs) T
    (and (not (and (find (car xs) "ABCDEFGHIJKLMNOPQRSTUVWXYZ")
                   (find (car xs) (cdr xs))))
         (is-isogram-helper (cdr xs)))))

(defun is-isogram (xs)
  (is-isogram-helper (str-list xs)))
