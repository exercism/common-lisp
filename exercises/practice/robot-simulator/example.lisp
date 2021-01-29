(defpackage #:robot-simulator
  (:use #:common-lisp)
  (:export #:+north+ #:+east+ #:+south+ #:+west+ #:execute-sequence
           #:robot #:robot-position #:robot-bearing #:make-robot))

(in-package #:robot-simulator)

(defconstant +north+ #C(0 1))
(defconstant +east+ #C(1 0))
(defconstant +south+ #C(0 -1))
(defconstant +west+ #C(-1 0))

(defclass robot ()
  ((position
    :initarg :position
    :initform #C(0 0))
   (bearing
    :reader robot-bearing
    :initarg :bearing
    :initform +north+)))

(defun make-robot (&key (position '(0 . 0)) (bearing +north+))
  (make-instance 'robot
                 :position (complex (car position) (cdr position))
                 :bearing bearing))

(defmethod robot-position ((robot robot))
  (with-slots (position) robot
    (cons (realpart position) (imagpart position))))

(defmethod turn-right ((robot robot))
  (with-slots (bearing) robot
    (setf bearing (* bearing #C(0 -1)))))

(defmethod turn-left ((robot robot))
  (with-slots (bearing) robot
    (setf bearing (* bearing #C(0 1)))))

(defmethod advance ((robot robot))
  (with-slots (bearing position) robot
    (incf position bearing)))

(defmethod execute-sequence ((robot robot) sequence)
  (loop
    for op across sequence
    do (case op
         ((#\L #\l) (turn-left robot))
         ((#\R #\r) (turn-right robot))
         ((#\A #\a) (advance robot)))))
