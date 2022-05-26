(defpackage :proverb
  (:use :cl)
  (:export :recite))

(in-package :proverb)

(defun recite (strings)
  (if strings
    (let* ((interleaved (apply #'append (mapcar #'list strings strings)))
           (without-ends (cdr (butlast interleaved)))
           (proverb-bulk (format nil "~{For want of a ~A the ~A was lost.~%~}" without-ends)))
      (format nil "~AAnd all for the want of a ~A." proverb-bulk (car strings)))
    ""))
