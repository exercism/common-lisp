(ql:quickload "lisp-unit")

(defpackage #:atbash-cipher-test
  (:use #:common-lisp #:lisp-unit))

#-xlisp-test (load "atbash-cipher")

(in-package #:atbash-cipher-test)

(define-test encode-no
  (assert-equal "ml" (atbash-cipher:encode "no")))

(define-test encode-yes
  (assert-equal "bvh" (atbash-cipher:encode "yes")))

(define-test encode-OMG
  (assert-equal "lnt" (atbash-cipher:encode "OMG")))

(define-test encode-O-M-G
  (assert-equal "lnt" (atbash-cipher:encode "O M G")))

(define-test encode-long-word
  (assert-equal "nrmwy oldrm tob"
                (atbash-cipher:encode "mindblowingly")))

(define-test encode-numbers
  (assert-equal "gvhgr mt123 gvhgr mt"
                (atbash-cipher:encode "Testing, 1 2 3, testing.")))

(define-test encode-sentence
  (assert-equal "gifgs rhurx grlm"
                (atbash-cipher:encode "Truth is fiction.")))

(define-test encode-all-the-things
  (let ((plaintext "The quick brown fox jumps over the lazy dog.")
        (cipher "gsvjf rxpyi ldmul cqfnk hlevi gsvoz abwlt"))
    (assert-equal cipher (atbash-cipher:encode plaintext))))

#-xlisp-test
(let ((*print-errors* t)
      (*print-failures* t))
  (run-tests :all :atbash-cipher-test))
