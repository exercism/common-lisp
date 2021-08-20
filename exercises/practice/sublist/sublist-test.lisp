;; Ensures that sublist.lisp and the testing library are always loaded
(eval-when (:compile-toplevel :load-toplevel :execute)
  (load "sublist")
  (quicklisp-client:quickload :fiveam))

;; Defines the testing package with symbols from sublist and FiveAM in scope
;; The `run-tests` function is exported for use by both the user and test-runner
(defpackage :sublist-test
  (:use :cl :fiveam)
  (:export :run-tests))

;; Enter the testing package
(in-package :sublist-test)

;; Define and enter a new FiveAM test-suite
(def-suite* sublist-suite)

(test empty-lists (is (equal :equal (sublist:sublist (list) (list)))))

(test list-equals-itself
 (is (equal :equal (sublist:sublist (list 1 2 3) (list 1 2 3)))))

(test different-lists
 (is (equal :unequal (sublist:sublist (list 1 2 3) (list 2 3 4)))))

(test first-list-missing-element-from-second-list
 (is (equal :unequal (sublist:sublist (list 1 3) (list 1 2 3)))))

(test second-list-missing-element-from-first-list
 (is (equal :unequal (sublist:sublist (list 1 2 3) (list 1 3)))))

(test order-matters-to-a-lists
 (is (equal :unequal (sublist:sublist (list 1 2 3) (list 3 2 1)))))

(test same-digits-different-numbers
 (is (equal :unequal (sublist:sublist (list 1 0 1) (list 10 1)))))

(test empty-list-within-non-empty-list
 (is (equal :sublist (sublist:sublist (list) (list 1 2 3)))))

(test false-start
 (is (equal :sublist (sublist:sublist (list 1 2 5) (list 0 1 2 3 1 2 5 6)))))

(test consecutive
 (is (equal :sublist (sublist:sublist (list 1 1 2) (list 0 1 1 1 2 1 2)))))

(test sublist-at-start
 (is (equal :sublist (sublist:sublist (list 0 1 2) (list 0 1 2 3 4 5)))))

(test sublist-in-middle
 (is (equal :sublist (sublist:sublist (list 2 3 4) (list 0 1 2 3 4 5)))))

(test sublist-at-end
 (is (equal :sublist (sublist:sublist (list 3 4 5) (list 0 1 2 3 4 5)))))

(test not-empty-list-contains-empty-list
 (is (equal :superlist (sublist:sublist (list 1 2 3) (list)))))

(test at-start-of-superlist
 (is (equal :superlist (sublist:sublist (list 0 1 2 3 4 5) (list 0 1 2)))))

(test in-middle-of-superlist
 (is (equal :superlist (sublist:sublist (list 0 1 2 3 4 5) (list 2 3)))))

(test at-end-superlist
 (is (equal :superlist (sublist:sublist (list 0 1 2 3 4 5) (list 3 4 5)))))

(defun run-tests (&optional (test-or-suite 'sublist-suite))
  "Provides human readable results of test run. Default to entire suite."
  (run! test-or-suite))
