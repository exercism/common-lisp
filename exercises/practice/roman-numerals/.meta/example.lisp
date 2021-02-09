(defpackage #:roman-numerals
  (:use #:cl)
  (:export #:romanize))

(in-package #:roman-numerals)

(defun romanize (number)
  (format nil "~@R" number))
