(defpackage :allergies
  (:use :cl)
  (:shadow :list)
  (:export :allergic-to-p :list))

(in-package :allergies)

(defun allergic-to-p (score allergen)
  "Returns true if given allergy score includes given allergen."
  )

(defun list (score)
  "Returns a list of allergens for a given allergy score."
  )
