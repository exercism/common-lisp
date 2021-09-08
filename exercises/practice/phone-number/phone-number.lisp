(defpackage :phone-number
  (:use :cl)
  (:export :clean))

(in-package :phone-number)

(defun clean (phrase)
  "Converts a PHRASE string into a string of digits.
Will evaluate to \"0000000000\" in case of an invalid input."
  )
