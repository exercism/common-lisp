(defpackage :resistor-color-duo
  (:use :cl)
  (:export :value))

(in-package :resistor-color-duo)

(defun value (colors)
  (let ((tens (color-code (first colors)))
        (ones (color-code (second colors))))
    (+ (* tens 10) ones)))

(defun color-code (color)
  (position color (color-values) :test #'string=))

(defun color-values ()
  '("black" "brown" "red" "orange" "yellow" "green" "blue" "violet" "grey" "white"))
