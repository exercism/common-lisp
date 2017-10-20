(defpackage #:sublist
  (:use #:common-lisp)
  (:export #:sublist))

(in-package #:sublist)

(defun is-prefix-of (xs ys)
  (cond ((null xs)                 T)
        ((null ys)                 NIL)
        ((equal (car xs) (car ys)) (is-prefix-of (cdr xs) (cdr ys)))
        (T                         NIL)))

(defun sublist-of (xs ys)
  (if (and xs (null ys))
    nil
    (or (is-prefix-of xs ys) (sublist-of xs (cdr ys)))))

(defun sublist (xs ys)
  (let ((sub   (sublist-of xs ys))
        (super (sublist-of ys xs)))
    (cond ((and sub super) "equal")
          (sub             "sublist")
          (super           "superlist")
          (T               "unequal"))))
