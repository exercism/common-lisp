(defpackage :phone-number
  (:use :common-lisp)
  (:export :clean))

(in-package :phone-number)

(defun strip-non-digits (string)
  (remove-if-not #'digit-char-p string))

(defun trim-leading-one (string)
  (if (and (= 11 (length string))
           (equal #\1 (char string 0)))
      (subseq string 1)
      string))

(defun starts-with-0-or-1-p (string) (member (char string 0) '(#\0 #\1)))

(defun valid-length-p (string) (= (length string) 10))
(defun valid-area-code-p (string) (not (starts-with-0-or-1-p (subseq string 0 3))))
(defun valid-exchange-code-p (string) (not (starts-with-0-or-1-p (subseq string 3 6))))

(defun call-predicate-on (x) (lambda (pred) (funcall pred x)))

(defun clean (phrase)
  (let ((number-string (trim-leading-one (strip-non-digits phrase))))
    (if (every (call-predicate-on number-string)
               '(valid-length-p valid-area-code-p valid-exchange-code-p))
        number-string
        "0000000000")))
