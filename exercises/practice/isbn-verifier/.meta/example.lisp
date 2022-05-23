(defpackage :isbn-verifier
  (:use :cl)
  (:export :validp))

(in-package :isbn-verifier)

(defun char-to-num (input-char)
  (if (char= #\X input-char) 10 (digit-char-p input-char)))

(defun validp (isbn)
  (let ((cleaned (remove-if-not #'alphanumericp isbn)))
    (when (= 10 (length cleaned)) ; Check isbn is 10 chars long
      (let ((num-list (map 'list #'char-to-num cleaned))) ; Map chars to numbers (or nil)
        ; Return nil if any nils in num-list or if any of the first 9 nums eql 10
        (unless (or (some #'null num-list) (member 10 (butlast num-list)))
          (zerop (mod (apply #'+ (mapcar #'* num-list '(10 9 8 7 6 5 4 3 2 1))) 11)))))))
