(defpackage #:strain
  (:use #:cl)
  (:export #:keep #:discard))

(in-package #:strain)

(defun keep (keep-p elements)
  "Returns a sublist of elements according to a given predicate."
  )

(defun discard (discard-p elements)
  "Returns a sublist of elements not matching a given predicate."
  )
