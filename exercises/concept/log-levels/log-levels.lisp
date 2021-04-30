(defpackage :log-levels
  (:use :cl)
  (:export :log-message :log-severity :log-format))

(in-package :log-levels)

(defun log-message (log-string))

(defun log-severity (log-string))

(defun log-format (log-string))
