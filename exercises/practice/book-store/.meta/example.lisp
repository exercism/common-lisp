(defpackage :book-store
  (:use :cl)
  (:export :calculate-price))

(in-package :book-store)

(defparameter +discounts+ #(0.0 0.05 0.1 0.2 0.25))

(defun calculate-price (basket)
 (if basket
  (let ((groupings (improve-groupings (create-groups basket))))
    (apply '+ (mapcar #'calculate-group-price groupings)))
   0))

;;; Function to recursively find the largest groups possible from the basket.
;;; Returns the length of each group of books.
(defun create-groups (basket)
  (unless (zerop (list-length basket))
    (let ((group (remove-duplicates basket)))
      (loop for book in group
        do (setf basket (remove book basket :count 1)))
      (cons (list-length group) (create-groups basket)))))

;;; Function to replace every pair of lengths 3 & 5 with pairs of length 4 & 4.
;;; This is required to correctly calculate the price, as pairs of 4 & 4 are
;;; less expensive than pairs of 5 & 3.
(defun improve-groupings (groupings)
 (if (subsetp '(3 5) groupings)
   (improve-groupings (append '(4 4) (remove 5 (remove 3 groupings :count 1) :count 1)))
   groupings))

(defun calculate-group-price (group)
  (let ((one-minus-discount (- 1 (aref +discounts+ (1- group)))))
    (* 800 group one-minus-discount)))
