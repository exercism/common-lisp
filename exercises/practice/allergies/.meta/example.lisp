(defpackage #:allergies
  (:use #:common-lisp)
  (:shadow #:list)
  (:export #:allergic-to-p #:list))

(in-package #:allergies)

(defparameter *allergens-scores*
  '(("eggs" 1)
    ("peanuts" 2)
    ("shellfish" 4)
    ("strawberries" 8)
    ("tomatoes" 16)
    ("chocolate" 32)
    ("pollen" 64)
    ("cats" 128)))

(defun allergen (allergen-and-score) (first allergen-and-score))
(defun score (allergen-and-score) (second allergen-and-score))

(defun score-matches (allergen-and-score score)
  (not (zerop (logand (score allergen-and-score) score))))

(defun find-all (test sequence)
  (loop for i in sequence
     when (funcall test i) collecting i))

(defun list (score)
  (mapcar #'allergen
          (find-all
           #'(lambda (as) (score-matches as score))
           *allergens-scores*)))

(defun allergic-to-p (score allergen)
  (score-matches (assoc allergen *allergens-scores* :test #'string-equal)
                 score))
