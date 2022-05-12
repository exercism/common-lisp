(defpackage :isbn-verifier
  (:use :cl)
  (:export :validp))

(in-package :isbn-verifier)

(defun validp (isbn)
  (let ((cleaned (remove-if-not #'alphanumericp isbn)))
    (when (= 10 (length cleaned)) ; Check isbn is 10 chars long
      (let ((num-list (map 'list #'char-to-num cleaned))) ; Map chars to numbers (or nil)
        (unless (some #'null num-list) ; Return nil if any nils in num-list
          (unless (member 10 (butlast num-list)) ; Return nil if any of the first 9 nums eql 10
            (setq total (apply #'+ (mapcar #'* num-list '(10 9 8 7 6 5 4 3 2 1))))
            (zerop (mod total 11))))))))

(defun char-to-num (input-char)
  (if (char= #\X input-char) 10 (digit-char-p input-char)))
