(defpackage :reporting-for-duty
  (:use :cl)
  (:export :format-quarter-value :format-two-quarters
           :format-two-quarters-for-reading))

(in-package :reporting-for-duty)

(defun format-quarter-value (quarter value)
  (format nil "The value ~A quarter: ~A" quarter value))

(defun format-two-quarters (stream quarter1 value1 quarter2 value2)
  (format stream "~%~A~&~A~&"
          (format-quarter-value quarter1 value1)
          (format-quarter-value quarter2 value2)))

(defun format-two-quarters-for-reading (stream quarter1 value1 quarter2 value2)
  (format stream "(~S ~S)"
          (format-quarter-value quarter1 value1)
          (format-quarter-value quarter2 value2)))
