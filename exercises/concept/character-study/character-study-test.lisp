;; Ensures that character-study.lisp and the testing library are always loaded
(eval-when (:compile-toplevel :load-toplevel :execute)
  (load "character-study")
  (ql:quickload :fiveam))

;; Defines the testing package with symbols from character-study and FiveAM in scope
;; The `run-tests` function is exported for use by both the user and test-runner
(defpackage :character-study-test
  (:use :cl :fiveam :character-study)
  (:export :run-tests))

;; Enter the testing package
(in-package :character-study-test)

(def-suite character-study-suite)
(in-suite character-study-suite)

(test comparing-characters
  (is (eq :greater-than (compare-chars #\Z #\A)))
  (is (eq :less-than (compare-chars #\b #\d)))
  (is (eq :equal-to (compare-chars #\X #\X)))
  (is (eq :equal-to (compare-chars #\Space #\Space))))

(test character-size
  (is (eq :big (size-of-char #\A)))
  (is (eq :small (size-of-char #\m)))
  (is (eq :no-size (size-of-char #\Newline))))

(test upcase-downcase
  (is (char= #\A (change-size-of-char #\a :big)))
  (is (char= #\x (change-size-of-char #\x :small)))
  (is (char= #\0 (change-size-of-char #\0 :big)))
  (is (char= #\Space (change-size-of-char #\Space :small))))

(test character-type
  (is (eq :alpha (type-of-char #\M)))
  (is (eq :numeric (type-of-char #\8)))
  (is (eq :space (type-of-char #\Space)))
  (is (eq :newline (type-of-char #\Newline)))
  (is (eq :unknown (type-of-char #\!))))

(defun run-tests (&optional (test-or-suite 'character-study-suite))
  "Provides human readable results of test run. Default to entire suite."
  (run! test-or-suite))
