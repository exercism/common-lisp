(defpackage :robot-name
  (:use :common-lisp)
  (:export :build-robot :robot-name :reset-name :robot))

(in-package :robot-name)

(defun random-alpha-char ()
  (let ((alphabet "ABCDEFGHIJKLMNOPQRSTUVWXYZ"))
    (char alphabet (random 26))))

(defun random-digit-char ()
  (let ((digits "0123456789"))
    (char digits (random 10))))

(defun random-robot-name ()
  (concatenate 'string (list (random-alpha-char)
                             (random-alpha-char)
                             (random-digit-char)
                             (random-digit-char)
                             (random-digit-char))))

(defun build-robot () (make-instance 'robot))
(defclass robot ()
  ((name :reader robot-name :initform (random-robot-name))))
(defun reset-name (robot)
  (setf (slot-value robot 'name) (random-robot-name)))
