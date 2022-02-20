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

(test empty-lists (is (eq :equal (sublist:sublist (list) (list)))))

(test list-equals-itself
 (is (eq :equal (sublist:sublist (list 1 2 3) (list 1 2 3)))))

(test different-lists
 (is (eq :unequal (sublist:sublist (list 1 2 3) (list 2 3 4)))))

(test first-list-missing-element-from-second-list
 (is (eq :unequal (sublist:sublist (list 1 3) (list 1 2 3)))))

(test second-list-missing-element-from-first-list
 (is (eq :unequal (sublist:sublist (list 1 2 3) (list 1 3)))))

(test first-list-missing-additional-digits-from-second-list
 (is (eq :unequal (sublist:sublist (list 1 2) (list 1 22)))))

(test order-matters-to-a-lists
 (is (eq :unequal (sublist:sublist (list 1 2 3) (list 3 2 1)))))

(test same-digits-different-numbers
 (is (eq :unequal (sublist:sublist (list 1 0 1) (list 10 1)))))

(test empty-list-within-non-empty-list
 (is (eq :sublist (sublist:sublist (list) (list 1 2 3)))))

(test false-start
 (is (eq :sublist (sublist:sublist (list 1 2 5) (list 0 1 2 3 1 2 5 6)))))

(test consecutive
 (is (eq :sublist (sublist:sublist (list 1 1 2) (list 0 1 1 1 2 1 2)))))

(test sublist-at-start
 (is (eq :sublist (sublist:sublist (list 0 1 2) (list 0 1 2 3 4 5)))))

(test sublist-in-middle
 (is (eq :sublist (sublist:sublist (list 2 3 4) (list 0 1 2 3 4 5)))))

(test sublist-at-end
 (is (eq :sublist (sublist:sublist (list 3 4 5) (list 0 1 2 3 4 5)))))

(test not-empty-list-contains-empty-list
 (is (eq :superlist (sublist:sublist (list 1 2 3) (list)))))

(test at-start-of-superlist
 (is (eq :superlist (sublist:sublist (list 0 1 2 3 4 5) (list 0 1 2)))))

(test in-middle-of-superlist
 (is (eq :superlist (sublist:sublist (list 0 1 2 3 4 5) (list 2 3)))))

(test at-end-superlist
 (is (eq :superlist (sublist:sublist (list 0 1 2 3 4 5) (list 3 4 5)))))

(defun run-tests (&optional (test-or-suite 'sublist-suite))
  "Provides human readable results of test run. Default to entire suite."
  (run! test-or-suite))
