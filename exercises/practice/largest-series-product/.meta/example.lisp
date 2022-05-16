(defpackage :largest-series-product
  (:use :cl)
  (:export :largest-product))

(in-package :largest-series-product)

(defun largest-product (digits span)
 (when (valid-input-p digits span)
  (if (zerop span)
   1
   (apply #'max (mapcar #'string-to-product (windows digits span))))))

(defun windows (seq span)
  (loop for start from 0 to (- (length seq) span)
        for end from span to (length seq)
    collect (subseq seq start end)))

(defun string-to-product (seq)
  (apply #'* (map 'list #'digit-char-p seq)))

(defun valid-input-p (digits span)
  (and (every #'digit-char-p digits)
       (not (minusp span))
       (>= (length digits) span)))
