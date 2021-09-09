(defpackage :strain
  (:use :common-lisp)
  (:export :keep :discard))

(in-package :strain)

(defun keep (pred seq)
  (labels
      ((recurse (s r)
         (cond ((null s) (reverse r))
               ((funcall pred (car s))
                (recurse (cdr s) (cons (car s) r)))
               (t (recurse (cdr s) r)))))
    (recurse seq (list))))

(defun discard (pred seq)
  (keep (complement pred) seq))
