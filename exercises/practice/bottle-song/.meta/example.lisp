(defpackage :bottle-song
  (:use :cl)
  (:export :recite))

(in-package :bottle-song)

(defparameter +quantities+
  '((10 . "ten")
    (9  . "nine")
    (8  . "eight")
    (7  . "seven")
    (6  . "six")
    (5  . "five")
    (4  . "four")
    (3  . "three")
    (2  . "two")
    (1  . "one")
    (0  . "no")))


(defun pluralize (quantity)
  (if (eq quantity 1) "bottle" "bottles"))

(defun line (index)
  (let ((count (string-capitalize (cdr (assoc index +quantities+))))
        (word (pluralize index)))
   (format nil "~a green ~a hanging on the wall," count word)))

(defun verse (index)
  (let ((word (pluralize (- index 1)))
        (count (cdr (assoc (- index 1) +quantities+))))
       (list (line index)
             (line index)
             "And if one green bottle should accidentally fall,"
             (format nil "There'll be ~a green ~a hanging on the wall." count word))))
  
(defun recite (start-bottles take-down)
 (reduce (lambda (acc line)
          (if (zerop (length acc))
              line
              (concatenate  'string acc "\n\n" line)))
         (map 'list
               #'verse
               (loop for n from 0 below take-down collect (- start-bottles n)))
         :initial-value ""))
