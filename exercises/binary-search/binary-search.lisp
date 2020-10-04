(in-package #:cl-user)
(defpackage #:binary-search
  (:use #:common-lisp)
  (:export #:binary-find #:value-error))

(in-package #:binary-search)

(define-condition value-error (error)
  ())

(defun binary-find (arr el)
  )
