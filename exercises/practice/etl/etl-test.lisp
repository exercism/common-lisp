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

(defun hash-table-from-alist (kvs)
  "Test helper method to create a hash table from a list of key-value pairs."
  (reduce #'(lambda (h kv) (setf (gethash (car kv) h) (cdr kv)) h)
          kvs
          :initial-value (make-hash-table)))

(defun hash-table-to-alist (table)
  (let ((alist (list)))
    (maphash #'(lambda (k v) (setq alist (acons k v alist))) table)
    (sort alist #'char< :key #'first)))

(defun hash-table-kv-equal (expected actual)
  "Compare hash tables by comparing their key value pairs."
  (equal (hash-table-to-alist expected) (hash-table-to-alist actual)))

;; useful here for making nicer error messages in failed tests.
(defmethod print-object ((obj hash-table) stream)
  (print-unreadable-object (obj stream :type t)
    (format stream "with keys & values: ~S" (hash-table-to-alist obj))))

(test single-letter
  (is (hash-table-kv-equal
       (hash-table-from-alist '((#\a . 1)))
       (etl:transform (hash-table-from-alist '((1 . (#\A))))))))

(test single-score-with-multiple-letters
  (is (hash-table-kv-equal
       (hash-table-from-alist '((#\a . 1) (#\e . 1) (#\i . 1) (#\o . 1) (#\u . 1)))
       (etl:transform (hash-table-from-alist '((1 . (#\A #\E #\I #\O #\U))))))))

(test multiple-scores-with-multiple-letters
  (is (hash-table-kv-equal
       (hash-table-from-alist '((#\a . 1) (#\d . 2) (#\e . 1) (#\g . 2)))
       (etl:transform (hash-table-from-alist '((1 . (#\A #\E)) (2 . (#\D #\G))))))))

(test multiple-scores-with-differing-numbers-of-letters
  (is (hash-table-kv-equal
       (hash-table-from-alist
        '((#\a . 1) (#\b . 3) (#\c . 3) (#\d . 2) (#\e . 1)
          (#\f . 4) (#\g . 2) (#\h . 4) (#\i . 1) (#\j . 8)
          (#\k . 5) (#\l . 1) (#\m . 3) (#\n . 1) (#\o . 1)
          (#\p . 3) (#\q . 10) (#\r . 1) (#\s . 1) (#\t . 1)
          (#\u . 1) (#\v . 4) (#\w . 4) (#\x . 8) (#\y . 4)
          (#\z . 10)))
       (etl:transform (hash-table-from-alist
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
