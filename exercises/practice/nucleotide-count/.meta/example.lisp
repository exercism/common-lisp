(defpackage :nucleotide-count
  (:use :common-lisp)
  (:export :dna-count :nucleotide-counts :invalid-nucleotide))

(in-package :nucleotide-count)

(defparameter +valid-nucleotides+ (list #\A #\C #\G #\T))

(defun nucleotide-counts (strand)
  (when (every #'(lambda (n) (member n +valid-nucleotides+ :test #'char=)) strand)
    (mapcar #'(lambda (n) (cons n (count n strand :test #'char=))) +valid-nucleotides+)))
