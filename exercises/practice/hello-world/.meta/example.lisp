(defpackage :hello-world
  (:use :cl)
  (:export :hello))

(in-package :hello-world)

(defun hello () "Hello, World!")
