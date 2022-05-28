(defpackage :say
  (:use :cl)
  (:export :say))

(in-package :say)

(defun say (number)
  (unless (or (minusp number) (>= number (expt 10 12)))
    (remove #\, (format nil "~R" number))))
