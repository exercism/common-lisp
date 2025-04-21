(defpackage :resistor-color-trio
  (:use :cl)
  (:export :label))

(in-package :resistor-color-trio)

(defun label (colors)
  (let* ((tens (color-code (first colors)))
         (ones (color-code (second colors)))
         (multiplier (color-code (third colors)))
         (value (* (+ (* tens 10) ones) (expt 10 multiplier))))
    (format-label value)))

(defun format-label (value)
  (cond ((< value 1e3) (format nil "~a ohms" value))
        ((< value 1e6) (format nil "~a kiloohms" (floor value 1e3)))
        ((< value 1e9) (format nil "~a megaohms" (floor value 1e6)))
        ((< value 1e12) (format nil "~a gigaohms" (floor value 1e9)))
        (t (error "Value ~a is too large to be formatted" value))))

(defun color-code (color)
  (position color (color-values) :test #'string=))

(defun color-values ()
  '("black" "brown" "red" "orange" "yellow" "green" "blue" "violet" "grey" "white"))
