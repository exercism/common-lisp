;; Ensures that etl.lisp and the testing library are always loaded
(eval-when (:compile-toplevel :load-toplevel :execute)
  (load "etl")
  (quicklisp-client:quickload :fiveam))

;; Defines the testing package with symbols from etl and FiveAM in scope
;; The `run-tests` function is exported for use by both the user and test-runner
(defpackage :etl-test
  (:use :cl :fiveam)
  (:export :run-tests))

;; Enter the testing package
(in-package :etl-test)

;; Define and enter a new FiveAM test-suite
(def-suite* etl-suite)

(defun make-hash (kvs)
  "Test helper method to create a hash table from a list of key-value pairs."
  (reduce #'(lambda (h kv) (setf (gethash (car kv) h) (cdr kv)) h)
          kvs
          :initial-value (make-hash-table)))

(test single-letter
  (is (equalp (make-hash '((#\A . 1)))
              (etl:transform (make-hash '((1 . (#\A))))))))

(test single-score-with-multiple-letters
  (is (equalp (make-hash '((#\A . 1) (#\E . 1) (#\I . 1) (#\O . 1) (#\U . 1)))
              (etl:transform (make-hash '((1 . (#\A #\E #\I #\O #\U))))))))

(test multiple-scores-with-multiple-letters
  (is (equalp (make-hash '((#\A . 1) (#\D . 2) (#\E . 1) (#\G . 2)))
              (etl:transform (make-hash '((1 . (#\A #\E)) (2 . (#\D #\G))))))))

(test multiple-scores-with-differing-numbers-of-letters
  (is (equalp (make-hash
               '((#\A . 1) (#\B . 3) (#\C . 3) (#\D . 2) (#\E . 1)
                 (#\F . 4) (#\G . 2) (#\H . 4) (#\I . 1) (#\J . 8)
                 (#\K . 5) (#\L . 1) (#\M . 3) (#\N . 1) (#\O . 1)
                 (#\P . 3) (#\Q . 10) (#\R . 1) (#\S . 1) (#\T . 1)
                 (#\U . 1) (#\V . 4) (#\W . 4) (#\X . 8) (#\Y . 4)
                 (#\Z . 10)))
              (etl:transform (make-hash
                              '((1 . (#\A #\E #\I #\O #\U #\L #\N #\R #\S #\T))
                                (2 . (#\D #\G))
                                (3 . (#\B #\C #\M #\P))
                                (4 . (#\F #\H #\V #\W #\Y))
                                (5 . (#\K))
                                (8 . (#\J #\X))
                                (10 . (#\Q #\Z))))))))

(defun run-tests (&optional (test-or-suite 'etl-suite))
  "Provides human readable results of test run. Default to entire suite."
  (run! test-or-suite))
