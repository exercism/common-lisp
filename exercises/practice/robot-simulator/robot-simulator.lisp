(defpackage :robot-simulator
  (:use :cl)
  (:export :+north+ :+east+ :+south+ :+west+ :execute-sequence
           :robot :robot-position :robot-bearing :make-robot))

(in-package :robot-simulator)

(defun make-robot (&key position bearing))
  "A robot has a position on a grid made up of a cons of positive numbers,
  and a bearing of +north+ +south+ +east+ or +west+"
 
(defun execute-sequence (robot sequence))
  "Moves and rotates the robot according to the sequence"

(defun robot-position (robot))
  "Returns the robot's position"

(defun robot-bearing (robot))
  "Returns the robot's bearing"
