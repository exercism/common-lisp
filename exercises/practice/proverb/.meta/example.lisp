(defpackage :proverb
  (:use :cl)
  (:export :recite))

(in-package :proverb)

(defun recite (strings)
  (when strings
    (loop for x in (butlast strings) for y in (cdr strings)
      collect (format nil "For want of a ~A the ~A was lost." x y) into output
      finally (return (append output (list (format nil "And all for the want of a ~A." (car strings))))))))
