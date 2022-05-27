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

(defparameter +null-character+ (code-char 0))

(defun cleanup-ciphered-sequence (seq)
  (remove +null-character+ seq))

(defun opposite-char (c)
  (let* ((alphabet "abcdefghijklmnopqrstuvwxyz")
         (reverse (reverse alphabet)))
    (char reverse (position c alphabet))))

(defun encipher (c)
  (cond ((alpha-char-p c) (opposite-char (char-downcase c)))
        ((digit-char-p c) c)
        (t +null-character+)))

(defun to-cipher-sequence (plaintext)
  (cleanup-ciphered-sequence (map 'list #'encipher plaintext)))

(defun encode (plaintext)
  (to-string (group (to-cipher-sequence plaintext))))
