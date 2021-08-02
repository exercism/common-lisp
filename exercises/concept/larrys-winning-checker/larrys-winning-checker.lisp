(defpackage :larrys-winning-checker
  (:use :cl)
  (:export
   :make-empty-board
   :make-board-from-list
   :all-the-same-p
   :row
   :column))

(in-package :larrys-winning-checker)

(defun make-empty-board ())

(defun make-board-from-list (list))

(defun all-the-same-p (row-or-col))

(defun row (board row-num))

(defun column (board col-num))
