(defpackage :grade-school
  (:use :common-lisp)
  (:export :make-school :add :roster :grade))

(in-package :grade-school)

(defstruct school (roster (make-hash-table)))

(defun add (school name grade)
  (let ((current-roster (roster school)))
    (when (not (member name current-roster :test #'string=))
      (push name (grade school grade)))))

(defun roster (school)
  (let ((grades-and-names (list)))
    (maphash #'(lambda (grade names) (push (cons grade names) grades-and-names))
             (school-roster school))
    (reduce #'(lambda (roster grade-names) (append roster (cdr grade-names)))
            (sort grades-and-names #'< :key #'car)
            :initial-value (list))))

(defun grade (school grade)
  (gethash grade (school-roster school)))

(defun (setf grade) (newval school grade)
  (setf (gethash grade (school-roster school))
        (sort newval #'string<)))
