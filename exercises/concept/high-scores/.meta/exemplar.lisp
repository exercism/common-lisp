(defpackage :high-scores
  (:use :cl)
  (:export :make-high-scores-table :add-player
           :set-score :get-score :remove-player))

(in-package :high-scores)

(defun make-high-scores-table () (make-hash-table))

(defun add-player (table player) (setf (gethash player table) 0))

(defun set-score (table player score) (setf (gethash player table) score))

(defun get-score (table player) (gethash player table 0))

(defun remove-player (table player) (remhash player table))
