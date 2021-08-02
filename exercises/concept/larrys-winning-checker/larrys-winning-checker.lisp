(defpackage :larrys-winning-checker
  (:use :cl)
  (:export
   :make-empty-board
   :make-board-from-list
   :left-and-right
   :above-and-below))

(in-package :larrys-winning-checker)

(defun make-empty-board ())

(defun make-board-from-list (list))

(defun left-and-right (board col row))

(defun above-and-below (board col row))
