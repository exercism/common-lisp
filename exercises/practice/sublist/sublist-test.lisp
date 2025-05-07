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

(test empty-lists
    (let ((list-one '())
          (list-two '()))
      (is (eq :equal (sublist:sublist list-one list-two)))))

(test empty-list-within-non-empty-list
    (let ((list-one '())
          (list-two '(1 2 3)))
      (is (eq :sublist (sublist:sublist list-one list-two)))))

(test non-empty-list-contains-empty-list
    (let ((list-one '(1 2 3))
          (list-two '()))
      (is (eq :superlist (sublist:sublist list-one list-two)))))

(test list-equals-itself
    (let ((list-one '(1 2 3))
          (list-two '(1 2 3)))
      (is (eq :equal (sublist:sublist list-one list-two)))))

(test different-lists
    (let ((list-one '(1 2 3))
          (list-two '(2 3 4)))
      (is (eq :unequal (sublist:sublist list-one list-two)))))

(test false-start
    (let ((list-one '(1 2 5))
          (list-two '(0 1 2 3 1 2 5 6)))
      (is (eq :sublist (sublist:sublist list-one list-two)))))

(test consecutive
    (let ((list-one '(1 1 2))
          (list-two '(0 1 1 1 2 1 2)))
      (is (eq :sublist (sublist:sublist list-one list-two)))))

(test sublist-at-start
    (let ((list-one '(0 1 2))
          (list-two '(0 1 2 3 4 5)))
      (is (eq :sublist (sublist:sublist list-one list-two)))))

(test sublist-in-middle
    (let ((list-one '(2 3 4))
          (list-two '(0 1 2 3 4 5)))
      (is (eq :sublist (sublist:sublist list-one list-two)))))

(test sublist-at-end
    (let ((list-one '(3 4 5))
          (list-two '(0 1 2 3 4 5)))
      (is (eq :sublist (sublist:sublist list-one list-two)))))

(test at-start-of-superlist
    (let ((list-one '(0 1 2 3 4 5))
          (list-two '(0 1 2)))
      (is (eq :superlist (sublist:sublist list-one list-two)))))

(test in-middle-of-superlist
    (let ((list-one '(0 1 2 3 4 5))
          (list-two '(2 3)))
      (is (eq :superlist (sublist:sublist list-one list-two)))))

(test at-end-of-superlist
    (let ((list-one '(0 1 2 3 4 5))
          (list-two '(3 4 5)))
      (is (eq :superlist (sublist:sublist list-one list-two)))))

(test first-list-missing-element-from-second-list
    (let ((list-one '(1 3))
          (list-two '(1 2 3)))
      (is (eq :unequal (sublist:sublist list-one list-two)))))

(test second-list-missing-element-from-first-list
    (let ((list-one '(1 2 3))
          (list-two '(1 3)))
      (is (eq :unequal (sublist:sublist list-one list-two)))))

(test first-list-missing-additional-digits-from-second-list
    (let ((list-one '(1 2))
          (list-two '(1 22)))
      (is (eq :unequal (sublist:sublist list-one list-two)))))

(test order-matters-to-a-list
    (let ((list-one '(1 2 3))
          (list-two '(3 2 1)))
      (is (eq :unequal (sublist:sublist list-one list-two)))))

(test same-digits-but-different-numbers
    (let ((list-one '(1 0 1))
          (list-two '(10 1)))
      (is (eq :unequal (sublist:sublist list-one list-two)))))

(defun run-tests (&optional (test-or-suite 'sublist-suite))
  "Provides human readable results of test run. Default to entire suite."
  (run! test-or-suite))
