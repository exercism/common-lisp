(defpackage :rotational-cipher
  (:use :cl)
  (:export :rotate))

(in-package :rotational-cipher)

(defparameter +letters+ "abcdefghijklmnopqrstuvwxyz")

(defun rotate (text key)
  (loop while (>= key 26) do (decf key 26))
  (let* ((lower-letters (coerce +letters+ 'list))
         (upper-letters (coerce (string-upcase +letters+) 'list))
         (doubled-letters (concatenate 'string +letters+ +letters+))
         (lower-offset (coerce (subseq doubled-letters key (+ key 26)) 'list))
         (upper-offset (coerce (subseq (string-upcase doubled-letters) key (+ key 26)) 'list))
         (lookup (pairlis lower-letters lower-offset (pairlis upper-letters upper-offset))))
    (map 'string (lambda (c) (if (alpha-char-p c) (cdr (assoc c lookup)) c)) text)))
