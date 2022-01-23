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

(test roster-is-empty-when-no-students-added
  (let ((school (grade-school:make-school)))
    (is (equalp '() (grade-school:roster school)))))

(test add-a-student
  (let ((school (grade-school:make-school)))
    (is (grade-school:add school "Aimee" 2))))

(test student-is-added-to-roster
  (let ((school (grade-school:make-school)))
    (grade-school:add school "Aimee" 2)
    (is (equalp '("Aimee")
                (grade-school:roster school)))))

(test adding-multiple-students-in-the-same-grade-in-the-roster
  (let ((school (grade-school:make-school)))
    (is (grade-school:add school "Blair" 2))
    (is (grade-school:add school "James" 2))
    (is (grade-school:add school "Paul" 2))))

(test multiple-students-in-the-same-grade-are-added-to-the-roster
  (let ((school (grade-school:make-school)))
    (grade-school:add school "Blair" 2)
    (grade-school:add school "James" 2)
    (grade-school:add school "Paul" 2)

    (is (equal '("Blair" "James" "Paul") (grade-school:roster school)))))

(test cannot-add-student-to-same-grade-in-the-roster-more-than-once
  (let ((school (grade-school:make-school)))
    (is (grade-school:add school "Blair" 2))
    (is (grade-school:add school "James" 2))
    (is (not (grade-school:add school "James" 2)))
    (is (grade-school:add school "Paul" 2))))

(test student-not-added-to-same-grade-in-the-roster-more-than-once
  (let ((school (grade-school:make-school)))
    (grade-school:add school "Blair" 2)
    (grade-school:add school "James" 2)
    (grade-school:add school "James" 2)
    (grade-school:add school "Paul" 2)

    (is (equal '("Blair" "James" "Paul") (grade-school:roster school)))))

(test adding-student-in-multiple-grades
  (let ((school (grade-school:make-school)))
    (is (grade-school:add school "Chelsea" 3))
    (is (grade-school:add school "Logan" 7))))

(test students-in-multiple-grades-are-added-to-the-roster
  (let ((school (grade-school:make-school)))
    (grade-school:add school "Chelsea" 3)
    (grade-school:add school "Logan" 7)

    (is (equal '("Chelsea" "Logan") (grade-school:roster school)))))

(test cannot-add-same-student-to-multiple-grades-in-the-roster
  (let ((school (grade-school:make-school)))
    (is (grade-school:add school "Blair" 2))
    (is (grade-school:add school "James" 2))
    (is (not (grade-school:add school "James" 3)))
    (is (grade-school:add school "Paul" 2))))

(test student-not-added-to-multiple-grades-in-the-roster
  (let ((school (grade-school:make-school)))
    (grade-school:add school "Blair" 2)
    (grade-school:add school "James" 2)
    (grade-school:add school "James" 3)
    (grade-school:add school "Paul" 2)

    (is (equal '("Blair" "James" "Paul") (grade-school:roster school)))))

(test students-are-sorted-by-grades-in-the-roster
  (let ((school (grade-school:make-school)))
    (grade-school:add school "Jim" 3)
    (grade-school:add school "Peter" 2)
    (grade-school:add school "Anna" 1)

    (is (equal '("Anna" "Peter" "Jim") (grade-school:roster school)))))

(test students-are-sorted-by-name-in-the-roster
  (let ((school (grade-school:make-school)))
    (grade-school:add school "Peter" 2)
    (grade-school:add school "Zoe" 2)
    (grade-school:add school "Alex" 2)

    (is (equal '("Alex" "Peter" "Zoe") (grade-school:roster school)))))

(test students-are-sorted-by-grade-then-by-name-in-the-roster
  (let ((school (grade-school:make-school)))
    (grade-school:add school "Peter" 2)
    (grade-school:add school "Anna" 1)
    (grade-school:add school "Barb" 1)
    (grade-school:add school "Zoe" 2)
    (grade-school:add school "Alex" 2)
    (grade-school:add school "Jim" 3)
    (grade-school:add school "Charlie" 1)

    (is (equal '("Anna" "Barb" "Charlie" "Alex" "Peter" "Zoe" "Jim")
               (grade-school:roster school)))))

(test grade-is-empty-if-no-students-in-the-roster
  (let ((school (grade-school:make-school)))
    (is (equal '() (grade-school:grade school 1)))))

(test grade-is-empty-if-no-students-in-that-grade
  (let ((school (grade-school:make-school)))
    (grade-school:add school "Peter" 2)
    (grade-school:add school "Zoe" 2)
    (grade-school:add school "Alex" 2)
    (grade-school:add school "Jim" 3)

    (is (equal '() (grade-school:grade school 1)))))

(test student-not-added-to-same-grade-more-than-once
  (let ((school (grade-school:make-school)))
    (grade-school:add school "Blair" 2)
    (grade-school:add school "James" 2)
    (grade-school:add school "James" 2)
    (grade-school:add school "Paul" 2)

    (is (equal '("Blair" "James" "Paul") (grade-school:grade school 2)))))

(test student-not-added-to-multiple-grades
  (let ((school (grade-school:make-school)))
    (grade-school:add school "Blair" 2)
    (grade-school:add school "James" 2)
    (grade-school:add school "James" 3)
    (grade-school:add school "Paul" 3)

    (is (equal '("Blair" "James") (grade-school:grade school 2)))))

(test student-not-added-to-other-grade-for-multiple-grades
  (let ((school (grade-school:make-school)))
    (grade-school:add school "Blair" 2)
    (grade-school:add school "James" 2)
    (grade-school:add school "James" 3)
    (grade-school:add school "Paul" 3)

    (is (equal '("Paul") (grade-school:grade school 3)))))

(test students-are-sorted-by-name-in-a-grade
  (let ((school (grade-school:make-school)))
    (grade-school:add school "Franklin" 5)
    (grade-school:add school "Bradley" 5)
    (grade-school:add school "Jeff" 1)

    (is (equal '("Bradley" "Franklin") (grade-school:grade school 5)))))

(defun run-tests (&optional (test-or-suite 'grade-school-suite))
  "Provides human readable results of test run. Default to entire suite."
  (run! test-or-suite))
