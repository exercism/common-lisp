;; Ensures that isogram.lisp and the testing library are always loaded
(eval-when (:compile-toplevel :load-toplevel :execute)
  (load "isogram")
  (quicklisp-client:quickload :fiveam))

;; Defines the testing package with symbols from isogram and FiveAM in scope
;; The `run-tests` function is exported for use by both the user and test-runner
(defpackage :isogram-test
  (:use :cl :fiveam)
  (:export :run-tests))

;; Enter the testing package
(in-package :isogram-test)

;; Define and enter a new FiveAM test-suite
(def-suite* isogram-suite)

(test empty-string (is (isogram:isogram-p "")))

(test isogram-with-only-lower-case-characters
  (is (isogram:isogram-p "isogram")))

(test word-with-one-duplicated-character
  (is (not (isogram:isogram-p "eleven"))))

(test word-with-one-duplicated-character-from-the-end-of-the-alphabet
  (is (not (isogram:isogram-p "zzyzx"))))

(test longest-reported-english-isogram
  (is (isogram:isogram-p "subdermatoglyphic")))

(test word-with-duplicated-character-in-mixed-case
  (is (not (isogram:isogram-p "Alphabet"))))

(test word-with-duplicated-character-in-mixed-case-lowercase-first
  (is (not (isogram:isogram-p "alphAbet"))))

(test hypothetical-isogrammic-word-with-hyphen
  (is (isogram:isogram-p "thumbscrew-japingly")))

(test hypothetical-word-with-duplicated-character-following-hyphen
  (is (not (isogram:isogram-p "thumbscrew-jappingly"))))

(test isogram-with-duplicated-hyphen (is (isogram:isogram-p "six-year-old")))

(test made-up-name-that-is-an-isogam
  (is (isogram:isogram-p "Emily Jung Schwartzkopf")))

(test duplicated-character-in-the-middle
  (is (not (isogram:isogram-p "accentor"))))

(test same-first-and-last-characters
  (is (not (isogram:isogram-p "angola"))))

(test word-with-duplicated-character-and-with-two-hyphens
  (is (not (isogram:isogram-p "up-to-date"))))

(defun run-tests (&optional (test-or-suite 'isogram-suite))
  "Provides human readable results of test run. Default to entire suite."
  (run! test-or-suite))
