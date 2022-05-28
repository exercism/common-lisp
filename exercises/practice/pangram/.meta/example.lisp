(defpackage :pangram
  (:use :cl)
  (:export :pangramp))

(in-package :pangram)

(defun pangramp (sentence)
 (let ((filtered (remove-if-not #'alpha-char-p (string-downcase sentence))))
   (= 26 (length (remove-duplicates filtered)))))
