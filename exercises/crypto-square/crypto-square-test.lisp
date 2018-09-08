(ql:quickload "lisp-unit")
#-xlisp-test (load "crypto-square")

(defpackage #:crypto-square-test
  (:use #:common-lisp #:lisp-unit))

(in-package #:crypto-square-test)

(define-test empty-plaintext-results-in-an-empty-ciphertext
  (assert-equal
   ""
   (crypto-square:encipher "")))
(define-test lowercase
  (assert-equal
   "a"
   (crypto-square:encipher"A")))
(define-test remove-spaces
  (assert-equal
   "b"
   (crypto-square:encipher "  b ")))
(define-test remove-punctuation
  (assert-equal
   "1"
   (crypto-square:encipher "@1,%!")))
(define-test 9-character-plaintext-results-in-3-chunks-of-3-characters
  (assert-equal
   "tsf hiu isn"
   (crypto-square:encipher "This is fun!")))
(define-test 8-character-plaintext-results-in-3-chunks-the-last-one-with-a-trailing-space
  (assert-equal
   "clu hlt io "
   (crypto-square:encipher "Chill out.")))
(define-test 54-character-plaintext-results-in-7-chunks-the-last-two-with-trailing-spaces
  (assert-equal
   "imtgdvs fearwer mayoogo anouuio ntnnlvt wttddes aohghn  sseoau "
   (crypto-square:encipher "If man was meant to stay on the ground, god would have given us roots.")))

#-xlisp-test
(let ((*print-errors* t)
      (*print-failures* t))
  (run-tests :all))
