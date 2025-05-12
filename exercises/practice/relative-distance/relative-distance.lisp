(defpackage :relative-distance
  (:use :cl)
  (:export :degree-of-separation))

(in-package :relative-distance)

(defun degree-of-separation (family-tree person-a person-b))
