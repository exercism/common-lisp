(defpackage :triangle
  (:use :cl)
  (:export :triangle-type-p))

(in-package :triangle)

;; (defun triangle (a b c)
;;   (let ((sorted (sort (list a b c) #'>)))
;;     (if (>= (first sorted) (apply #'+ (rest sorted))) :illogical
;;         (case (length (remove-duplicates sorted))
;;           (1 :equilateral)
;;           (2 :isosceles)
;;           (3 :scalene)))))

(defun triangle-type-p (type a b c)
  "Deterimines if a triangle (given by side lengths A, B, C) is of the given TYPE"
  (let ((sorted (sort (list a b c) #'>)))
    (when (< (first sorted) (apply #'+ (rest sorted))) ; triangle-inequality
      (let ((num-unique-lengths (length (remove-duplicates (list a b c)))))
        (case type
          (:equilateral (= num-unique-lengths 1))
          (:isosceles (<= num-unique-lengths 2))
          (:scalene (= num-unique-lengths 3)))))))
