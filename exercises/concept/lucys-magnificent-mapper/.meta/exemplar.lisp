(defpackage :lucys-magnificent-mapper
  (:use :cl)
  (:export :make-magnificent-maybe :only-the-best))

(in-package :lucys-magnificent-mapper)

(defun make-magnificent-maybe (fn list)
  (mapcar fn list))

(defun only-the-best (fn list)
  (remove-if fn (remove 1 list)))
