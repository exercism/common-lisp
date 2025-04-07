(defpackage :reverse-string
  (:use :cl)
  (:export :reverse-string))

(in-package :reverse-string)

(defun reverse-string (value)
  "Reverse the string `value`. Handle wide characters with care.")
