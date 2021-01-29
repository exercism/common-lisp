(in-package #:cl-user)
(defpackage #:robot-simulator
  (:use #:common-lisp)
  (:export #:+north+ #:+east+ #:+south+ #:+west+ #:execute-sequence
           #:robot #:robot-position #:robot-bearing #:make-robot))

(in-package #:robot-simulator)
