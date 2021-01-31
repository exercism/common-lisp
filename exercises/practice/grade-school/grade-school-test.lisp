(ql:quickload "lisp-unit")
#-xlisp-test (load "grade-school")

(defpackage #:grade-school-test
  (:use #:common-lisp #:lisp-unit))

(in-package #:grade-school-test)

(define-test grade-roster-is-initially-empty
  (let ((school (grade-school:make-school)))
    (assert-equalp '() (grade-school:grade-roster school))))

(define-test add-student
  (let ((school (grade-school:make-school)))
    (grade-school:add school "Aimee" 2)
    (assert-equalp '((:grade 2 :students ("Aimee")))
                   (grade-school:grade-roster school))))

(define-test add-more-students-in-same-class
  (let ((school (grade-school:make-school)))
    (grade-school:add school "James" 2)
    (grade-school:add school "Blair" 2)
    (grade-school:add school "Paul" 2)
    (let ((grade2 (first (grade-school:grade-roster school))))
      (assert-equalp 2 (getf grade2 :grade))
      (assert-equalp '("Blair" "James" "Paul")
                     (sort (getf grade2 :students) #'string<)))))

(define-test add-students-to-different-grades
  (let ((school (grade-school:make-school)))
    (grade-school:add school "Chelsea" 3)
    (grade-school:add school "Logan" 7)
    (assert-equalp '((:grade 3 :students ("Chelsea"))
                     (:grade 7 :students ("Logan")))
                   (sort (grade-school:grade-roster school) #'< :key #'second))))

(define-test get-students-in-a-grade
  (let ((school (grade-school:make-school)))
    (grade-school:add school "Franklin" 5)
    (grade-school:add school "Bradley" 5)
    (grade-school:add school "Jeff" 1)
    (assert-equalp '("Bradley" "Franklin")
                   (sort (grade-school:grade school 5) #'string<))))

(define-test get-students-in-a-non-existant-grade
  (let ((school (grade-school:make-school)))
    (assert-equalp '() (grade-school:grade school 1))))

(define-test sorted-school
  (let ((school (grade-school:make-school)))
    (grade-school:add school "Jennifer" 4)
    (grade-school:add school "Kareem" 6)
    (grade-school:add school "Christopher" 4)
    (grade-school:add school "Kyle" 3)
    (assert-equalp '((:grade 3 :students ("Kyle"))
                     (:grade 4 :students ("Christopher" "Jennifer"))
                     (:grade 6 :students ("Kareem")))
                   (grade-school:sorted school))))

#-xlisp-test
(let ((*print-errors* t)
      (*print-failures* t))
  (run-tests :all :grade-school-test))
