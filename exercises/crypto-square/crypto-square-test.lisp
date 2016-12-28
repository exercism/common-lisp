(ql:quickload "lisp-unit")
#-xlisp-test (load "crypto-square")

(defpackage #:crypto-square-test
  (:use #:common-lisp #:lisp-unit))

(in-package #:crypto-square-test)

(define-test super-simple
  (assert-equal
   "ac bd"
   (crypto-square:encipher "abcd")))

(define-test still-simple
  (assert-equal
   "ttt iao cce"
   (crypto-square:encipher "tic tac toe"))  )

(define-test a-little-harder
  (assert-equal
   "acb bar rda aa" (crypto-square:encipher "abracadabra")))

(define-test example-1
  (assert-equal
   "hifei acedl veeol eddgo aatcu nyhht"
   (crypto-square:encipher "Have a nice day. Feed the dog & chill out!")))

(define-test example-2
  (assert-equal
   "imtgdvs fearwer mayoogo anouuio ntnnlvt wttddes aohghn sseoau"
   (crypto-square:encipher "If man was meant to stay on the ground god would have given us roots")))

(define-test cipher-0
  (assert-equal
   "neewl exhie vtetw ehaho ririe vntds"
   (crypto-square:encipher "Never vex thine heart with idle woes.")))

(define-test cipher-1
  (assert-equal
   "tasney inicds miohoo elntu illib suuml"
   (crypto-square:encipher "Time is an illusion. Lunchtime doubly so.")))

(define-test cipher-2
  (assert-equal
   "wneiaw eorene awssci liprer lneoid ktcms"
   (crypto-square:encipher "We all know interspecies romance is weird.")))

(define-test cipher-3
  (assert-equal
   "msemo aanin dnin ndla etlt shui"
   (crypto-square:encipher "Madness, and then illumination.")))

(define-test cipher-4
  (assert-equal
   "vrel aepe mset paoo irpo"
   (crypto-square:encipher "Vampires are people too!")))

(define-test special-case
  (assert-equal
   "sator arepo tenet opera rotas"
   (crypto-square:encipher "sator arepo tenet opera rotas")))

#-xlisp-test
(let ((*print-errors* t)
      (*print-failures* t))
  (run-tests :all))
