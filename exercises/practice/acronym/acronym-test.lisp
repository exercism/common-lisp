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

(test basic
    (let ((phrase "Portable Network Graphics"))
      (is (string= "PNG" (acronym:acronym phrase)))))

(test lowercase-words
    (let ((phrase "Ruby on Rails"))
      (is (string= "ROR" (acronym:acronym phrase)))))

(test punctuation
    (let ((phrase "First In, First Out"))
      (is (string= "FIFO" (acronym:acronym phrase)))))

(test all-caps-word
    (let ((phrase "GNU Image Manipulation Program"))
      (is (string= "GIMP" (acronym:acronym phrase)))))

(test punctuation-without-whitespace
    (let ((phrase "Complementary metal-oxide semiconductor"))
      (is (string= "CMOS" (acronym:acronym phrase)))))

(test very-long-abbreviation
    (let ((phrase "Rolling On The Floor Laughing So Hard That My Dogs Came Over And Licked Me"))
      (is (string= "ROTFLSHTMDCOALM" (acronym:acronym phrase)))))

(test consecutive-delimiters
    (let ((phrase "Something - I made up from thin air"))
      (is (string= "SIMUFTA" (acronym:acronym phrase)))))

(test apostrophes
    (let ((phrase "Halley's Comet"))
      (is (string= "HC" (acronym:acronym phrase)))))

(test underscore-emphasis
    (let ((phrase "The Road _Not_ Taken"))
      (is (string= "TRNT" (acronym:acronym phrase)))))

(defun run-tests (&optional (test-or-suite 'acronym-suite))
  "Provides human readable results of test run. Default to entire suite."
  (run! test-or-suite))
