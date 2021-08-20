;; Ensures that binary-search.lisp and the testing library are always loaded
(eval-when (:compile-toplevel :load-toplevel :execute)
  (load "binary-search")
  (quicklisp-client:quickload :fiveam))

;; Defines the testing package with symbols from binary-search and FiveAM in scope
;; The `run-tests` function is exported for use by both the user and test-runner
(defpackage :binary-search-test
  (:use :cl :fiveam)
  (:export :run-tests))

;; Enter the testing package
(in-package :binary-search-test)

;; Define and enter a new FiveAM test-suite
(def-suite* binary-search-suite)

(test finds-a-value-in-an-array-with-one-element
 (is (equal (binary-search:binary-find #(6) 6) 0)))

(test finds-a-value-in-the-middle-of-an-array
 (is (equal (binary-search:binary-find #(1 3 4 6 8 9 11) 6) 3)))

(test finds-a-value-at-the-beginning-of-an-array
 (is (equal (binary-search:binary-find #(1 3 4 6 8 9 11) 1) 0)))

(test finds-a-value-at-the-end-of-an-array
 (is (equal (binary-search:binary-find #(1 3 4 6 8 9 11) 11) 6)))

(test finds-a-value-in-an-array-of-odd-length
 (is
  (equal
   (binary-search:binary-find #(1 3 5 8 13 21 34 55 89 144 233 377 634) 144)
   9)))

(test finds-a-value-in-an-array-of-even-length
 (is
  (equal (binary-search:binary-find #(1 3 5 8 13 21 34 55 89 144 233 377) 21)
         5)))

(test identifies-that-a-value-is-not-included-in-the-array
 (is (equal (binary-search:binary-find #(1 3 4 6 8 9 11) 7) nil)))

(test a-value-smaller-than-the-array-s-smallest-value-is-not-found
 (is (equal (binary-search:binary-find #(1 3 4 6 8 9 11) 0) nil)))

(test a-value-larger-than-the-array-s-largest-value-is-not-found
 (is (equal (binary-search:binary-find #(1 3 4 6 8 9 11) 13) nil)))

(test nothing-is-found-in-an-empty-array
 (is (equal (binary-search:binary-find #() 1) nil)))

(test nothing-is-found-when-the-left-and-right-bounds-cross
 (is (equal (binary-search:binary-find #(1 2) 0) nil)))

(defun run-tests (&optional (test-or-suite 'binary-search-suite))
  "Provides human readable results of test run. Default to entire suite."
  (run! test-or-suite))
