(defpackage #:roman
  (:use #:cl)
  (:export #:romanize))

(in-package #:roman)

(defun romanize (number)
  (format nil "~@R" number))
