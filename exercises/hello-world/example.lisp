(defpackage #:hello-world
  (:use #:common-lisp)
  (:export #:hello))

(in-package #:hello-world)

(defun hello () "Hello, World!")
