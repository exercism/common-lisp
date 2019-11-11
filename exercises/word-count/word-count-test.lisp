;;;
;;; word-count v1.4.0
;;;
;;; For each word in the input, count the number of times it appears in the
;;; entire sentence.
;;;
(ql:quickload "lisp-unit")
#-xlisp-test (load "word-count")

(defpackage #:word-count-test
  (:use #:common-lisp #:lisp-unit))
(in-package #:word-count-test)

(defun assert-alist-equal (expected actual)
  "The association lists must have the same length and the keys and
   values of the items must match. But the order is not
   important. Equality is tested with equal"
  (assert-equal
   (sort (copy-seq expected) #'string< :key #'car)
   (sort (copy-seq actual) #'string< :key #'car)))

(define-test
  count-one-word
  (assert-alist-equal
    '(("word" . 1))
    (word-count:count-words "word")))


(define-test
  count-one-of-each-word
  (assert-alist-equal
    '(("one" . 1) ("of" . 1) ("each" . 1))
    (word-count:count-words "one of each")))


(define-test
  multiple-occurrences-of-a-word
  (assert-alist-equal
    '(("one" . 1) ("fish" . 4) ("two" . 1) ("red" . 1) ("blue" . 1))
    (word-count:count-words "one fish two fish red fish blue fish")))


(define-test
  handles-cramped-lists
  (assert-alist-equal
    '(("one" . 1) ("two" . 1) ("three" . 1))
    (word-count:count-words "one,two,three")))


(define-test
  handles-expanded-lists
  (assert-alist-equal
    '(("one" . 1) ("two" . 1) ("three" . 1))
    (word-count:count-words "one,
two,
three")))


(define-test
  ignore-punctuation
  (assert-alist-equal
    '(("car" . 1) ("carpet" . 1) ("as" . 1) ("java" . 1) ("javascript" . 1))
    (word-count:count-words "car: carpet as java: javascript!!&@$%^&")))


(define-test
  include-numbers
  (assert-alist-equal
    '(("testing" . 2) ("1" . 1) ("2" . 1))
    (word-count:count-words "testing, 1, 2 testing")))


(define-test
  normalize-case
  (assert-alist-equal
    '(("go" . 3) ("stop" . 2))
    (word-count:count-words "go Go GO Stop stop")))


(define-test
  with-apostrophes
  (assert-alist-equal
    '(("first" . 1) ("don't" . 2) ("laugh" . 1) ("then" . 1) ("cry" . 1))
    (word-count:count-words "First: don't laugh. Then: don't cry.")))


(define-test
  with-quotations
  (assert-alist-equal
    '(("joe" . 1) ("can't" . 1) ("tell" . 1) ("between" . 1) ("large" . 2)
      ("and" . 1))
    (word-count:count-words "Joe can't tell between 'large' and large.")))


(define-test
  substrings-from-the-beginning
  (assert-alist-equal
    '(("joe" . 1) ("can't" . 1) ("tell" . 1) ("between" . 1) ("app" . 1)
      ("apple" . 1) ("and" . 1) ("a" . 1))
    (word-count:count-words "Joe can't tell between app, apple and a.")))


(define-test
  multiple-spaces-not-detected-as-a-word
  (assert-alist-equal
    '(("multiple" . 1) ("whitespaces" . 1))
    (word-count:count-words " multiple   whitespaces")))


(define-test
  alternating-word-separators-not-detected-as-a-word
  (assert-alist-equal
    '(("one" . 1) ("two" . 1) ("three" . 1))
    (word-count:count-words ",
,one,
 ,two
 'three'")))

#-xlisp-test
(let ((*print-errors* t)
      (*print-failures* t))
  (run-tests :all))
