(defpackage #:dna
  (:use #:common-lisp)
  (:export #:to-rna))

(in-package #:dna)

(defun validate-strand (strand)
  (or (every #'(lambda (c) (find c "ATCGU"))
	     (coerce strand 'list))
      (signal 'error)))

(defparameter dna->rna
  '((#\C . #\G) (#\G . #\C) (#\A . #\U) (#\T . #\A)))

(defun to-rna (strand)
  (validate-strand strand)
  (concatenate 'string
	       (mapcar #'(lambda (c) (cdr (assoc c dna->rna)))
		       (coerce strand 'list))))
