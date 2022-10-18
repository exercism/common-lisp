;; Ensures that word-count.lisp and the testing library are always loaded
(eval-when (:compile-toplevel :load-toplevel :execute)
  (load "word-count")
  (quicklisp-client:quickload :fiveam))

;; Defines the testing package with symbols from word-count and FiveAM in scope
;; The `run-tests` function is exported for use by both the user and test-runner
(defpackage :word-count-test
  (:use :cl :fiveam)
  (:export :run-tests))

;; Enter the testing package
(in-package :word-count-test)

;; Define and enter a new FiveAM test-suite
(def-suite* word-count-suite)

(defun assert-alist-equal (expected actual)
  "The association lists must have the same length and the keys and
   values of the items must match. But the order is not
   important. Equality is tested with equal"
  (equal (sort (copy-seq expected) #'string< :key #'car)
         (sort (copy-seq actual) #'string< :key #'car)))

(test count-one-word
  (is (assert-alist-equal
       '(("word" . 1))
       (word-count:count-words "word"))))

(test count-one-of-each-word
  (is(assert-alist-equal
      '(("one" . 1) ("of" . 1) ("each" . 1))
      (word-count:count-words "one of each"))))


(test multiple-occurrences-of-a-word
  (is (assert-alist-equal
       '(("one" . 1) ("fish" . 4) ("two" . 1) ("red" . 1) ("blue" . 1))
       (word-count:count-words "one fish two fish red fish blue fish"))))


(test handles-cramped-lists
  (is (assert-alist-equal
       '(("one" . 1) ("two" . 1) ("three" . 1))
       (word-count:count-words "one,two,three"))))


(test handles-expanded-lists
  (is (assert-alist-equal
       '(("one" . 1) ("two" . 1) ("three" . 1))
       (word-count:count-words "one,
two,
three"))))


(test ignore-punctuation
  (is (assert-alist-equal
       '(("car" . 1) ("carpet" . 1) ("as" . 1) ("java" . 1) ("javascript" . 1))
       (word-count:count-words "car: carpet as java: javascript!!&@$%^&"))))


(test include-numbers
  (is (assert-alist-equal
       '(("testing" . 2) ("1" . 1) ("2" . 1))
       (word-count:count-words "testing, 1, 2 testing"))))


(test normalize-case
  (is (assert-alist-equal
       '(("go" . 3) ("stop" . 2))
       (word-count:count-words "go Go GO Stop stop"))))


(test with-apostrophes
  (is (assert-alist-equal
       '(("first" . 1) ("don't" . 2) ("laugh" . 1) ("then" . 1) ("cry" . 1)
         ("you're" . 1) ("getting" . 1) ("it" . 1))
       (word-count:count-words
        "'First: don't laugh. Then: don't cry. You're getting it.'"))))


(test with-quotations
  (is (assert-alist-equal
       '(("joe" . 1) ("can't" . 1) ("tell" . 1) ("between" . 1) ("large" . 2)
         ("and" . 1))
       (word-count:count-words "Joe can't tell between 'large' and large."))))


(test substrings-from-the-beginning
  (is (assert-alist-equal
       '(("joe" . 1) ("can't" . 1) ("tell" . 1) ("between" . 1) ("app" . 1)
         ("apple" . 1) ("and" . 1) ("a" . 1))
       (word-count:count-words "Joe can't tell between app, apple and a."))))


(test multiple-spaces-not-detected-as-a-word
  (is (assert-alist-equal
       '(("multiple" . 1) ("whitespaces" . 1))
       (word-count:count-words " multiple   whitespaces"))))


(test alternating-word-separators-not-detected-as-a-word
  (is (assert-alist-equal
       '(("one" . 1) ("two" . 1) ("three" . 1))
       (word-count:count-words ",
,one,
 ,two
 'three'"))))

(test quotation-for-word-with-apostrophe
  (is (assert-alist-equal
       '(("can" . 1) ("can't" . 2))
       (word-count:count-words "can, can't, 'can't'"))))

(defun run-tests (&optional (test-or-suite 'word-count-suite))
  "Provides human readable results of test run. Default to entire suite."
  (run! test-or-suite))

