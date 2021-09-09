(defpackage :binary
  (:use :common-lisp)
  (:export :to-decimal))

(in-package :binary)

(defun to-decimal (string)
  (loop with digits = (remove-if #'null (map 'list #'(lambda (c) (digit-char-p c 2)) string))
     for idx below (length digits) and digit in (reverse digits)
       summing (* digit (expt 2 idx))))
