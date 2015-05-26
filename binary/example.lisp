(defpackage #:binary
  (:use #:common-lisp)
  (:export #:to-decimal))

(in-package #:binary)

(defun to-decimal (string)
  (or (parse-integer string :radix 2 :junk-allowed t)
      0))
