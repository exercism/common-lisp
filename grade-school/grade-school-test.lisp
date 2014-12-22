(ql:quickload "lisp-unit")

(defpackage #:grade-school-test
  (:use #:common-lisp #:lisp-unit))

(load "school")

(in-package #:grade-school-test)

(define-test grade-roster-is-initially-empty
  (let ((school (school:make-school)))
    (assert-equalp '() (school:grade-roster school))))

(define-test add-student
  (let ((school (school:make-school)))
    (school:add school "Aimee" 2)
    (assert-equalp '((:grade 2 :students ("Aimee")))
                   (school:grade-roster school))))

(define-test add-more-students-in-same-class
  (let ((school (school:make-school)))
    (school:add school "James" 2)
    (school:add school "Blair" 2)
    (school:add school "Paul" 2)
    (let ((grade2 (first (school:grade-roster school))))
      (assert-equalp 2 (getf grade2 :grade))
      (assert-equalp '("Blair" "James" "Paul")
                     (sort (getf grade2 :students) #'string<)))))

(define-test add-students-to-different-grades
  (let ((school (school:make-school)))
    (school:add school "Chelsea" 3)
    (school:add school "Logan" 7)
    (assert-equalp '((:grade 3 :students ("Chelsea"))
                     (:grade 7 :students ("Logan")))
                   (sort (school:grade-roster school) #'< :key #'second))))

(define-test get-students-in-a-grade
  (let ((school (school:make-school)))
    (school:add school "Franklin" 5)
    (school:add school "Bradley" 5)
    (school:add school "Jeff" 1)
    (assert-equalp '("Bradley" "Franklin")
                   (sort (school:grade school 5) #'string<))))

(define-test get-students-in-a-non-existant-grade
  (let ((school (school:make-school)))
    (assert-equalp '() (school:grade school 1))))

(define-test sorted-school
  (let ((school (school:make-school)))
    (school:add school "Jennifer" 4)
    (school:add school "Kareem" 6)
    (school:add school "Christopher" 4)
    (school:add school "Kyle" 3)
    (assert-equalp '((:grade 3 :students ("Kyle"))
                     (:grade 4 :students ("Christopher" "Jennifer"))
                     (:grade 6 :students ("Kareem")))
                   (school:sorted school))))

(let ((*print-errors* t)
      (*print-failures* t))
  (run-tests :all :grade-school-test))
