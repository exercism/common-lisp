(defpackage :say
  (:use :cl)
  (:export :say))

(in-package :say)

(defun say (number)
  (when (< -1 number (expt 10 12))
    (format nil "~r" number)))
