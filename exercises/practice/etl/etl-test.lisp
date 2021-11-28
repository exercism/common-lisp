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
  (is (equalp (make-hash '((#\a . 1)))
              (etl:transform (make-hash '((1 . (#\A))))))))

(test single-score-with-multiple-letters
  (is (equalp (make-hash '((#\a . 1) (#\e . 1) (#\i . 1) (#\o . 1) (#\u . 1)))
              (etl:transform (make-hash '((1 . (#\A #\E #\I #\O #\U))))))))

(test multiple-scores-with-multiple-letters
  (is (equalp (make-hash '((#\a . 1) (#\d . 2) (#\e . 1) (#\g . 2)))
              (etl:transform (make-hash '((1 . (#\A #\E)) (2 . (#\D #\G))))))))

(test multiple-scores-with-differing-numbers-of-letters
  (is (equalp (make-hash
               '((#\a . 1) (#\b . 3) (#\c . 3) (#\d . 2) (#\e . 1)
                 (#\f . 4) (#\g . 2) (#\h . 4) (#\i . 1) (#\j . 8)
                 (#\k . 5) (#\l . 1) (#\m . 3) (#\n . 1) (#\o . 1)
                 (#\p . 3) (#\q . 10) (#\r . 1) (#\s . 1) (#\t . 1)
                 (#\u . 1) (#\v . 4) (#\w . 4) (#\x . 8) (#\y . 4)
                 (#\z . 10)))
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
