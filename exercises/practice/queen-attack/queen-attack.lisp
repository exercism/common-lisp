(defpackage :queen-attack
  (:use :cl)
  (:export :create
           :attackp
           :queen))

(in-package :queen-attack)

(defstruct queen row column)

(defun create (coordinates))

(defun attackp (white-queen black-queen))
