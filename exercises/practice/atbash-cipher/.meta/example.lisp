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

(defun cleanup-ciphered-sequence (seq)
  (remove (code-char 0) seq))

(defun opposite-char (c)
  (code-char
   (- (char-code #\z)
      (- (char-code c)
         (char-code #\a)))))

(defun encipher (c)
  (cond ((alpha-char-p c) (opposite-char (char-downcase c)))
        ((digit-char-p c) c)
        (t (code-char 0))))

(defun to-cipher-sequence (plaintext)
  (cleanup-ciphered-sequence (map 'list #'encipher plaintext)))

(defun encode (plaintext)
  (to-string (group (to-cipher-sequence plaintext))))
