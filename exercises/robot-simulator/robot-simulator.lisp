(in-package #:cl-user)
(defpackage #:robot-simulator
  (:use #:common-lisp)
  (:export #:north #:east #:south #:west
	   #:turn-right #:turn-left #:advance #:execute-sequence
	   #:robot #:robot-position #:robot-bearing #:make-robot))

(in-package #:robot-simulator)
