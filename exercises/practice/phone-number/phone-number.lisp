(in-package #:cl-user)
(defpackage #:phone
  (:use #:common-lisp)
  (:export #:numbers #:area-code #:pretty-print))

(in-package #:phone)

(defun numbers (phone-number)
  "Converts a phone number string into a string of digits."
  )

(defun pretty-print (phone-number)
  "Converts a phone number string to a human-readable representation."
  )
