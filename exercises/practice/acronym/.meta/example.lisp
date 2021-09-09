(in-package :cl-user)
(defpackage :acronym
  (:use :cl)
  (:export :acronym))

(in-package :acronym)

(defun acronym (str)
  (labels ((recur (st ls)
    (cond
      ((equal "" st)
        ls)
      ((both-case-p (elt st 0))
       (recur (string-left-trim
              "abcdefghijklmnopqrstuvwxyz"
              (string-left-trim
                "ABCDEFGHIJKLMNOPQRSTUVWXYZ"
                st))
             (cons (elt st 0)
                   ls)))
      (t (recur (subseq st 1) ls)))))
    (map 'string
         #'char-upcase
         (nreverse (recur str nil)))))
