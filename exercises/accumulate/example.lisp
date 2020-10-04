(defpackage #:accumulate
  (:use #:common-lisp)
  (:export #:accumulate))

(in-package #:accumulate)

(defun accumulate (acc fn)
  (if (null acc)
      nil
      (cons (funcall fn (car acc))
	    (accumulate (cdr acc) fn))))
