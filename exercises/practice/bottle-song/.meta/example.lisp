(defpackage :bottle-song
  (:use :common-lisp)
  (:export :recite))

(in-package :bottle-song)

(defun verse (n)
  (list (format nil "~:(~R~) green bottle~:P hanging on the wall," n)
        (format nil "~:(~R~) green bottle~:P hanging on the wall," n)
        "And if one green bottle should accidentally fall,"
        (format nil "There'll be ~[no~:;~:*~R~] green bottle~:P hanging on the wall." (1- n))))

(defun recite (start-bottles take-down)
  "Returns the song verses from START-BOTTLES down to (- START-BOTTLES TAKE-DOWN)."
  (apply #'concatenate 'list
         (let ((first start-bottles)
               (last (- start-bottles take-down)))
           (loop for v from first above last
                 collect (verse v)
                 unless (= v (1+ last)) collect '("")))))
