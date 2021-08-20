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

(test empty-string (is (isogram:is-isogram "")))

(test isogram-with-only-lower-case-characters
 (is (isogram:is-isogram "isogram")))

(test word-with-one-duplicated-character
 (is (not (isogram:is-isogram "eleven"))))

(test longest-reported-english-isogram
 (is (isogram:is-isogram "subdermatoglyphic")))

(test word-with-duplicated-character-in-mixed-case
 (is (not (isogram:is-isogram "Alphabet"))))

(test hypothetical-isogrammic-word-with-hyphen
 (is (isogram:is-isogram "thumbscrew-japingly")))

(test isogram-with-duplicated-hyphen (is (isogram:is-isogram "six-year-old")))

(test made-up-name-that-is-an-isogam
 (is (isogram:is-isogram "Emily Jung Schwartzkopf")))

(test duplicated-character-in-the-middle
 (is (not (isogram:is-isogram "accentor"))))

(defun run-tests (&optional (test-or-suite 'isogram-suite))
  "Provides human readable results of test run. Default to entire suite."
  (run! test-or-suite))
