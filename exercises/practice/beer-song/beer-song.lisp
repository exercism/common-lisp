(in-package #:cl-user)
(defpackage #:beer
  (:use #:common-lisp)
  (:export #:verse #:sing))

(in-package #:beer)
(defun verse (n)
  "Returns a string verse for a given number."
  )

(defun sing (start &optional (end 0))
  "Returns a string of verses for a given range of numbers."
  )
