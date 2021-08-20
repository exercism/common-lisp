;; Ensures that acronym.lisp and the testing library are always loaded
(eval-when (:compile-toplevel :load-toplevel :execute)
  (load "acronym")
  (quicklisp-client:quickload :fiveam))

;; Defines the testing package with symbols from acronym and FiveAM in scope
;; The `run-tests` function is exported for use by both the user and test-runner
(defpackage :acronym-test
  (:use :cl :fiveam)
  (:export :run-tests))

;; Enter the testing package
(in-package :acronym-test)

;; Define and enter a new FiveAM test-suite
(def-suite* acronym-suite)

(test empty-gives-empty (is (equal "" (acronym:acronym ""))))

(test png-test (is (equal "PNG" (acronym:acronym "Portable Network Graphics"))))

(test ror-test (is (equal "ROR" (acronym:acronym "Ruby on Rails"))))

(test fifo-test (is (equal "FIFO" (acronym:acronym "First In, First Out"))))

(test php-test
 (is (equal "PHP" (acronym:acronym "PHP: Hypertext Preprocessor"))))

(test cmos-test
 (is
  (equal "CMOS" (acronym:acronym "Complementary metal-oxide semiconductor"))))

(defun run-tests (&optional (test-or-suite 'acronym-suite))
  "Provides human readable results of test run. Default to entire suite."
  (run! test-or-suite))
