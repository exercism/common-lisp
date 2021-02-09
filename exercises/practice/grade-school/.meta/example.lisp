(defpackage #:grade-school
  (:use #:common-lisp)
  (:export #:make-school #:add #:grade-roster #:grade #:sorted))

(in-package #:grade-school)

(defclass school ()
  ((roster :accessor roster :initform (make-hash-table))))

(defmethod grade-roster ((school school))
  (with-slots (roster) school
    (unless (zerop (hash-table-count roster))
      (loop
        for grade being each hash-key of roster
          using (hash-value students)
        collect (list :grade grade
                      :students (sort students #'string<))))))

(defmethod grade ((school school) grade)
  (gethash grade (roster school)))

(defun (setf grade) (new-value school grade)
  (setf (gethash grade (roster school)) new-value))

(defun make-school ()
  (make-instance 'school))

(defmethod add ((school school) student grade)
  (push student (grade school grade)))

(defmethod sorted ((school school))
  (sort (copy-list (grade-roster school)) #'< :key #'second))
