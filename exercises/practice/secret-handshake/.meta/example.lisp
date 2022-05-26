(defpackage :secret-handshake
  (:use :cl)
  (:export :commands))

(in-package :secret-handshake)

(defparameter +phrases+ #("wink" "double blink" "close your eyes" "jump"))

(defun commands (number)
  (loop for x from 0 below 4
    when (plusp (logand number (expt 2 x)))
    collect (aref +phrases+ x) into output
    finally (return (if (plusp (logand number 16)) (reverse output) output))))
