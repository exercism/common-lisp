(defpackage #:raindrops
  (:use #:common-lisp)
  (:export #:convert))

(in-package #:raindrops)

(defparameter *raindrops*
  '((3 . "Pling")
    (5 . "Plang")
    (7 . "Plong"))
  "Frequency modulus and impact sound of raindrops.")

(defun convert (integer &optional (raindrops *raindrops*))
  "String of integer or raindrop sound."
  (declare (type integer integer))
  (loop
     for (div . sound) of-type (integer . string) in raindrops
     when (zerop (mod integer div))
     collect sound into sounds
     finally
       (return
         (if sounds
             (format nil "~{~A~}" sounds)
             (write-to-string integer)))))
