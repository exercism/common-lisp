(defpackage :eliuds-eggs
  (:use :cl)
  (:export :egg-count))

(in-package :eliuds-eggs)

(defun do-egg-count (number &optional (acc 0))
  (if (= number 0)
    acc
    (multiple-value-bind (quot rem) (floor number 2)
      (do-egg-count quot (+ acc rem)))))

(defun egg-count (number)
  (do-egg-count number))
