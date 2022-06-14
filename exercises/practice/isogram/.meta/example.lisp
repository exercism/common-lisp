(defpackage :isogram
  (:use :common-lisp)
  (:export :isogram-p))

(in-package :isogram)

(defun isogram-p (xs)
  (let ((chars-only (remove-if-not #'alpha-char-p xs)))
    (string-equal chars-only
                  (remove-duplicates chars-only :test #'char-equal))))
