(defpackage :atbash-cipher
  (:use :common-lisp)
  (:export :encode))

(in-package :atbash-cipher)

(defun to-string (seq)
  (concatenate 'string seq))

(defun group (seq &optional (group-size 5))
  (loop
     for c in seq and i from 1
     collect c
     when (and (not (= i (length seq)))
               (zerop (mod i group-size)))
     collect #\Space))

(defparameter +key+
  (pairlis
   (coerce "abcdefghijklmnopqrstuvwxyz1234567890" 'list)
   (coerce "zyxwvutsrqponmlkjihgfedcba1234567890" 'list)))

(defun lookup-char (c) (cdr (assoc c +key+)))

(defun encode (plaintext)
  (let ((filtered (remove-if-not #'alphanumericp (string-downcase plaintext))))
     (to-string (group (map 'list #'lookup-char filtered)))))
