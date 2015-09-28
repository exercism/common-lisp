(defpackage #:accumulate
  (:use #:common-lisp)
  (:export #:accumulate))

(in-package #:accumulate)

(defun accumulate (pred list)
  (mapcar pred list))
