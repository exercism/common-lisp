(defpackage :larrys-winning-checker
  (:use :cl)
  (:export
   :make-empty-board
   :make-board-from-list
   :left-and-right
   :above-and-below))

(in-package :larrys-winning-checker)

(defun make-empty-board ()
  (make-array '(3 3) :initial-element nil))

(defun make-board-from-list (list)
  (make-array '(3 3) :initial-contents list))

(defun board-cell (board col row)
  (unless (or (or (< col 0) (> col 2))
              (or (< row 0) (> row 2)))
    (aref board col row)))

(defun left-and-right (board col row)
  (make-array 3 :initial-contents (list (board-cell board col (1- row))
                                        (board-cell board col row)
                                        (board-cell board col (1+ row)))))

(defun above-and-below (board col row)
  (make-array 3 :initial-contents (list (board-cell board (1- col) row)
                                        (board-cell board col row)
                                        (board-cell board (1+ col) row))))
