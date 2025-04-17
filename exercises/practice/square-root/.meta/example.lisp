(defpackage :square-root
  (:use :cl)
  (:export :square-root))

(in-package :square-root)

(defun square-root (radicand)
  (if (= radicand 1)   
    1
    (loop with guess = (floor radicand 2)
          repeat 10
          until (= radicand (* guess guess))
            do (setf guess (floor (+ guess (/ radicand guess)) 2))
          finally (return (and (= radicand (* guess guess)) guess)))))
