(defpackage :diamond
  (:use :cl)
  (:export :rows))

(in-package :diamond)

(defun rows (letter)
  (let* ((letters (loop for i from 65 to (char-code letter) collect (code-char i)))
         (columns (1- (* 2 (length letters))))
         (unique-rows (loop for c in letters and idx from 0
                        collect (let ((mid-space (abs (1- (* 2 idx)))))
                                  (format nil "~v:@<~,,v,A~:*~A~>" columns mid-space c)))))
    (rplaca unique-rows (format nil "~v:@<A~>" columns))
    (append unique-rows (reverse (butlast unique-rows)))))
