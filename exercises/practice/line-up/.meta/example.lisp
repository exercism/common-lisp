(defpackage :line-up
  (:use :cl)
  (:shadow :format)
  (:export :format))

(in-package :line-up)

(defun format (name number)
  (cl:format nil "~A, you are the ~A~A customer we serve today. Thank you!"
          name number (suffix number)))

(defun suffix (number)
  (cond
    ((= (mod number 100) 11) "th")
    ((= (mod number 100) 12) "th")
    ((= (mod number 100) 13) "th")
    ((= (mod number 10) 1) "st")
    ((= (mod number 10) 2) "nd")
    ((= (mod number 10) 3) "rd")
    (t "th")))
