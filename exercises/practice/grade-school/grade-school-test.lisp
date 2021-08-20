;; Ensures that grade-school.lisp and the testing library are always loaded
(eval-when (:compile-toplevel :load-toplevel :execute)
  (load "grade-school")
  (quicklisp-client:quickload :fiveam))

;; Defines the testing package with symbols from grade-school and FiveAM in scope
;; The `run-tests` function is exported for use by both the user and test-runner
(defpackage :grade-school-test
  (:use :cl :fiveam)
  (:export :run-tests))

;; Enter the testing package
(in-package :grade-school-test)

;; Define and enter a new FiveAM test-suite
(def-suite* grade-school-suite)

(test grade-roster-is-initially-empty
 (let ((school (grade-school:make-school)))
   (is (equalp 'nil (grade-school:grade-roster school)))))

(test add-student
 (let ((school (grade-school:make-school)))
   (grade-school:add school "Aimee" 2)
   (is
    (equalp '((:grade 2 :students ("Aimee")))
            (grade-school:grade-roster school)))))

(test add-more-students-in-same-class
 (let ((school (grade-school:make-school)))
   (grade-school:add school "James" 2)
   (grade-school:add school "Blair" 2)
   (grade-school:add school "Paul" 2)
   (let ((grade2 (first (grade-school:grade-roster school))))
     (is (equalp 2 (getf grade2 :grade)))
     (is
      (equalp '("Blair" "James" "Paul")
              (sort (getf grade2 :students) #'string<))))))

(test add-students-to-different-grades
 (let ((school (grade-school:make-school)))
   (grade-school:add school "Chelsea" 3)
   (grade-school:add school "Logan" 7)
   (is
    (equalp '((:grade 3 :students ("Chelsea")) (:grade 7 :students ("Logan")))
            (sort (grade-school:grade-roster school) #'< :key #'second)))))

(test get-students-in-a-grade
 (let ((school (grade-school:make-school)))
   (grade-school:add school "Franklin" 5)
   (grade-school:add school "Bradley" 5)
   (grade-school:add school "Jeff" 1)
   (is
    (equalp '("Bradley" "Franklin")
            (sort (grade-school:grade school 5) #'string<)))))

(test get-students-in-a-non-existant-grade
 (let ((school (grade-school:make-school)))
   (is (equalp 'nil (grade-school:grade school 1)))))

(test sorted-school
 (let ((school (grade-school:make-school)))
   (grade-school:add school "Jennifer" 4)
   (grade-school:add school "Kareem" 6)
   (grade-school:add school "Christopher" 4)
   (grade-school:add school "Kyle" 3)
   (is
    (equalp
     '((:grade 3 :students ("Kyle"))
       (:grade 4 :students ("Christopher" "Jennifer"))
       (:grade 6 :students ("Kareem")))
     (grade-school:sorted school)))))

(defun run-tests (&optional (test-or-suite 'grade-school-suite))
  "Provides human readable results of test run. Default to entire suite."
  (run! test-or-suite))
