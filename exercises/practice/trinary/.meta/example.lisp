(defpackage :trinary
  (:use :common-lisp)
  (:export :to-decimal))

(in-package :trinary)

(defun to-decimal (string)
  "Return the decimal value for STRING which is in trinary. If STRING
is not a valid trinary number then return 0."
  (or (ignore-errors (parse-integer string :radix 3))
      0))

;;;
;;; Another possible implementation, if one wanted to reimplement
;;; PARSE-INTEGER
;;;
;; (defun to-decimal (string)
;;   (loop with revstr = (reverse string)
;;      for idx below (length string) and c across revstr
;;      for digit = (digit-char-p c 3)
;;      if (not digit) return 0
;;      else summing (* digit (expt 3 idx))))

;;;
;;; Another possible implementation but has a security flaw.
;;; Ponder what would happen if STRING was
;;; "#.(delete-file \"/etc/passwd\")"
;;;
;; (defun to-decimal (string)
;;   (let* ((*read-base* 3)
;;          (value (read-from-string string)))
;;     (if (typep value 'number) value 0)))
