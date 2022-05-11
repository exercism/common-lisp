(defpackage :two-bucket
  (:use :cl)
  (:export :measure))

(in-package :two-bucket)

(defun measure (bucket-one bucket-two goal start-bucket))
