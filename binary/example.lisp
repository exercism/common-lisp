(defpackage #:binary
  (:use #:common-lisp)
  (:export #:to-decimal))

(in-package #:binary)

;; (defun to-decimal (string)
;;   (or (parse-integer string :radix 2 :junk-allowed t)
;;       0))

;; (defun to-decimal (string)
;;   (flet ((parse-digit (digit) (if (and digit (char= digit #\1)) 1 0)))
;;     (do* ((digits (reverse (coerce string 'list)) (rest digits))
;;           (digit (parse-digit (car digits))
;;                  (parse-digit (car digits)))
;;           (index 0 (incf index))
;;           (value (* digit
;;                     (expt 2 index))
;;                  (+ value (* digit
;;                              (expt 2 index)))))
;;          ((null digits) value))))

;; (defun to-decimal (string)
;;   (flet ((parse-digit (digit) (or (digit-char-p digit 2) 0)))
;;     (do* ((index 0 (incf index))
;;           (revstr (reverse string))
;;           (digit (parse-digit (char revstr index))
;;                  (parse-digit (char revstr index)))
;;           (value digit (+ value (* digit (expt 2 index)))))
;;          ((= (1+ index) (length string)) value))))

(defun to-decimal (string)
  (loop with revstr = (reverse string)
     for idx below (length string) and c across revstr
     for digit = (or (digit-char-p c 2) 0)
     summing (* digit (expt 2 idx))))
