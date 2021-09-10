(in-package :cl-user)
(defpackage :armstrong-numbers
  (:use :cl)
  (:export :armstrong-number-p))
(in-package :armstrong-numbers)

(defun number->digits (number)
  (map 'list #'digit-char-p (prin1-to-string number)))

(defun sum (numbers) (reduce #'+ numbers))

(defun armstrong-number-p (number)
  (let ((digits (number->digits number)))
    (= number
       (sum (mapcar #'(lambda (x) (expt x (length digits)))
                    digits)))))
