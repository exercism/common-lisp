;; Ensures that logans-numeric-partition.lisp and the testing library are always loaded
(eval-when (:compile-toplevel :load-toplevel :execute)
  (load "logans-numeric-partition")
  (ql:quickload :fiveam))

;; Defines the testing package with symbols from logans-numeric-partition and FiveAM in scope
;; The `run-tests` function is exported for use by both the user and test-runner
(defpackage :logans-numeric-partition-test
  (:use :cl :fiveam :logans-numeric-partition)
  (:export :run-tests))

;; Enter the testing package
(in-package :logans-numeric-partition-test)

;; Define and enter a new FiveAM test-suite
(def-suite logans-numeric-partition-suite)
(in-suite logans-numeric-partition-suite)

(test categorize-odd-numbers-collection-is-empty
  (is (equal '((1) . ()) (categorize-number '(() . ()) 1))))

(test categorize-odd-numbers-add-to-existing-collection
  (is (equal '((3 1) . ()) (categorize-number '((1) . ()) 3))))

(test categorize-odd-numbers-does-not-affect-even-collection
  (is (equal '((3 1) . (2)) (categorize-number '((1) . (2)) 3))))

(test categorize-even-numbers-collection-is-empty
      (is (equal '(() . (2)) (categorize-number '(() . ()) 2))))

(test categorize-even-numbers-add-to-existing-collection
  (is (equal '(() . (4 2)) (categorize-number '(() . (2)) 4))))

(test categorize-even-numbers-does-not-affect-even-collection
  (is (equal '((1) . (4 2)) (categorize-number '((1) . (2)) 4))))

(test partion-an-empty-list
      (is (equal '(() . ()) (partition-numbers '()))))

(test partition-list-of-one-number
      (is (equal '((1) . ()) (partition-numbers '(1))))
      (is (equal '(() . (2)) (partition-numbers '(2)))))

(test partition-several-numbers
      (is (equal '((5 3 1) . (6 4 2)) (partition-numbers '(1 2 3 4 5 6)))))

(defun run-tests (&optional (test-or-suite 'logans-numeric-partition-suite))
  "Provides human readable results of test run. Default to entire suite."
  (run! test-or-suite))
