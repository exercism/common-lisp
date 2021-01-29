(ql:quickload "lisp-unit")
#-xlisp-test (load "isogram")

(defpackage #:isogram-test
  (:use #:common-lisp #:lisp-unit))

(in-package #:isogram-test)

(define-test empty-string
  (assert-true (isogram:is-isogram "")))

(define-test isogram-with-only-lower-case-characters
  (assert-true (isogram:is-isogram "isogram")))

(define-test word-with-one-duplicated-character
  (assert-false (isogram:is-isogram "eleven")))

(define-test longest-reported-english-isogram
  (assert-true (isogram:is-isogram "subdermatoglyphic")))

(define-test word-with-duplicated-character-in-mixed-case
  (assert-false (isogram:is-isogram "Alphabet")))

(define-test hypothetical-isogrammic-word-with-hyphen
  (assert-true (isogram:is-isogram "thumbscrew-japingly")))

(define-test isogram-with-duplicated-hyphen
  (assert-true (isogram:is-isogram "six-year-old")))

(define-test made-up-name-that-is-an-isogam
  (assert-true (isogram:is-isogram "Emily Jung Schwartzkopf")))

(define-test duplicated-character-in-the-middle
  (assert-false (isogram:is-isogram "accentor")))

#-xlisp-test
(let ((*print-errors* t)
      (*print-failures* t))
  (run-tests :all :isogram-test))
