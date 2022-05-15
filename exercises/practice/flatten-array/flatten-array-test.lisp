;; Ensures that flatten-array.lisp and the testing library are always loaded
(eval-when (:compile-toplevel :load-toplevel :execute)
  (load "flatten-array")
  (quicklisp-client:quickload :fiveam))

;; Defines the testing package with symbols from flatten-array and FiveAM in scope
;; The `run-tests` function is exported for use by both the user and test-runner
(defpackage :flatten-array-test
  (:use :cl :fiveam)
  (:export :run-tests))

;; Enter the testing package
(in-package :flatten-array-test)

;; Define and enter a new FiveAM test-suite
(def-suite* flatten-array-suite)

(test empty
    (let ((nested (list)))
      (is (equal (list) (flatten-array:flatten nested)))))

(test no-nesting
    (let ((nested (list 0 1 2)))
      (is (equal (list 0 1 2) (flatten-array:flatten nested)))))

(test flattens-a-nested-array
    (let ((nested (list (list (list)))))
      (is (equal (list) (flatten-array:flatten nested)))))

(test flattens-array-with-just-integers-present
    (let ((nested (list 1 (list 2 3 4 5 6 7) 8)))
      (is (equal (list 1 2 3 4 5 6 7 8) (flatten-array:flatten nested)))))

(test 5-level-nesting
    (let ((nested (list 0 2 (list (list 2 3) 8 100 4 (list (list (list 50)))) -2)))
      (is (equal (list 0 2 2 3 8 100 4 50 -2) (flatten-array:flatten nested)))))

(test 6-level-nesting
    (let ((nested (list 1 (list 2 (list (list 3)) (list 4 (list (list 5))) 6 7) 8)))
      (is (equal (list 1 2 3 4 5 6 7 8) (flatten-array:flatten nested)))))

(test null-values-are-omitted-from-the-final-result
    (let ((nested (list 1 2 NIL)))
      (is (equal (list 1 2) (flatten-array:flatten nested)))))

(test consecutive-null-values-at-the-front-of-the-list-are-omitted-from-the-final-result
    (let ((nested (list NIL NIL 3)))
      (is (equal (list 3) (flatten-array:flatten nested)))))

(test consecutive-null-values-in-the-middle-of-the-list-are-omitted-from-the-final-result
    (let ((nested (list 1 NIL NIL 4)))
      (is (equal (list 1 4) (flatten-array:flatten nested)))))

(test 6-level-nest-list-with-null-values
    (let ((nested (list 0 2 (list (list 2 3) 8 (list (list 100)) NIL (list (list NIL))) -2)))
      (is (equal (list 0 2 2 3 8 100 -2) (flatten-array:flatten nested)))))

(test all-values-in-nested-list-are-null
    (let ((nested (list NIL (list (list (list NIL))) NIL NIL (list (list NIL NIL) NIL) NIL)))
      (is (equal (list) (flatten-array:flatten nested)))))

(defun run-tests (&optional (test-or-suite 'flatten-array-suite))
  "Provides human readable results of test run. Default to entire suite."
  (run! test-or-suite))
