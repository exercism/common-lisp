(ql:quickload "lisp-unit")
#-xlisp-test (load "robot-simulator")

(defpackage #:robot-simulator-test
  (:use #:common-lisp #:lisp-unit))

(in-package #:robot-simulator-test)

(define-test robots-are-created-with-defaults
  (let ((robot (robot-simulator:make-robot)))
    (assert-equal '(0 . 0) (robot-simulator:robot-position robot))
    (assert-equal robot-simulator:north (robot-simulator:robot-bearing robot))))

(define-test negative-coordinates-allowed
  (let ((robot (robot-simulator:make-robot :position '(-1 . -1) :bearing robot-simulator:south)))
    (assert-equal '(-1 . -1) (robot-simulator:robot-position robot))
    (assert-equal robot-simulator:south (robot-simulator:robot-bearing robot))))

(define-test turn-right-north-to-east
  (let ((robot (robot-simulator:make-robot :position '(0 . 0) :bearing robot-simulator:north)))
    (robot-simulator:execute-sequence robot "R")
    (assert-equal '(0 . 0) (robot-simulator:robot-position robot))
    (assert-equal robot-simulator:east (robot-simulator:robot-bearing robot))))

(define-test turn-right-east-to-south
  (let ((robot (robot-simulator:make-robot :position '(0 . 0) :bearing robot-simulator:east)))
    (robot-simulator:execute-sequence robot "R")
    (assert-equal '(0 . 0) (robot-simulator:robot-position robot))
    (assert-equal robot-simulator:south (robot-simulator:robot-bearing robot))))

(define-test turn-right-south-to-west
  (let ((robot (robot-simulator:make-robot :position '(0 . 0) :bearing robot-simulator:south)))
    (robot-simulator:execute-sequence robot "R")
    (assert-equal '(0 . 0) (robot-simulator:robot-position robot))
    (assert-equal robot-simulator:west (robot-simulator:robot-bearing robot))))

(define-test turn-right-west-to-north
  (let ((robot (robot-simulator:make-robot :position '(0 . 0) :bearing robot-simulator:west)))
    (robot-simulator:execute-sequence robot "R")
    (assert-equal '(0 . 0) (robot-simulator:robot-position robot))
    (assert-equal robot-simulator:north (robot-simulator:robot-bearing robot))))

(define-test turn-left-north-to-west
  (let ((robot (robot-simulator:make-robot :position '(0 . 0) :bearing robot-simulator:north)))
    (robot-simulator:execute-sequence robot "L")
    (assert-equal '(0 . 0) (robot-simulator:robot-position robot))
    (assert-equal robot-simulator:west (robot-simulator:robot-bearing robot))))

(define-test turn-left-west-to-south
  (let ((robot (robot-simulator:make-robot :position '(0 . 0) :bearing robot-simulator:west)))
    (robot-simulator:execute-sequence robot "L")
    (assert-equal '(0 . 0) (robot-simulator:robot-position robot))
    (assert-equal robot-simulator:south (robot-simulator:robot-bearing robot))))

(define-test turn-left-south-to-east
  (let ((robot (robot-simulator:make-robot :position '(0 . 0) :bearing robot-simulator:south)))
    (robot-simulator:execute-sequence robot "L")
    (assert-equal '(0 . 0) (robot-simulator:robot-position robot))
    (assert-equal robot-simulator:east (robot-simulator:robot-bearing robot))))

(define-test turn-left-east-to-north
  (let ((robot (robot-simulator:make-robot :position '(0 . 0) :bearing robot-simulator:east)))
    (robot-simulator:execute-sequence robot "L")
    (assert-equal '(0 . 0) (robot-simulator:robot-position robot))
    (assert-equal robot-simulator:north (robot-simulator:robot-bearing robot))))

(define-test advance-increments-y-when-facing-north
  (let ((robot (robot-simulator:make-robot :position '(0 . 0) :bearing robot-simulator:north)))
    (robot-simulator:execute-sequence robot "A")
    (assert-equal '(0 . 1) (robot-simulator:robot-position robot))
    (assert-equal robot-simulator:north (robot-simulator:robot-bearing robot))))

(define-test advance-decrements-y-when-facing-north
  (let ((robot (robot-simulator:make-robot :position '(0 . 0) :bearing robot-simulator:south)))
    (robot-simulator:execute-sequence robot "A")
    (assert-equal '(0 . -1) (robot-simulator:robot-position robot))
    (assert-equal robot-simulator:south (robot-simulator:robot-bearing robot))))

(define-test advance-increments-x-when-facing-east
  (let ((robot (robot-simulator:make-robot :position '(0 . 0) :bearing robot-simulator:east)))
    (robot-simulator:execute-sequence robot "A")
    (assert-equal '(1 . 0) (robot-simulator:robot-position robot))
    (assert-equal robot-simulator:east (robot-simulator:robot-bearing robot))))

(define-test advance-decrements-x-when-facing-west
  (let ((robot (robot-simulator:make-robot :position '(0 . 0) :bearing robot-simulator:west)))
    (robot-simulator:execute-sequence robot "A")
    (assert-equal '(-1 . 0) (robot-simulator:robot-position robot))
    (assert-equal robot-simulator:west (robot-simulator:robot-bearing robot))))

(define-test move-east-and-north-readme
  (let ((robot (robot-simulator:make-robot :position '(7 . 3) :bearing robot-simulator:north)))
    (robot-simulator:execute-sequence robot "RAALAL")
    (assert-equal '(9 . 4) (robot-simulator:robot-position robot))
    (assert-equal robot-simulator:west (robot-simulator:robot-bearing robot))))

(define-test move-west-and-north
  (let ((robot (robot-simulator:make-robot :position '(0 . 0) :bearing robot-simulator:north)))
    (robot-simulator:execute-sequence robot "LAAARALA")
    (assert-equal '(-4 . 1) (robot-simulator:robot-position robot))
    (assert-equal robot-simulator:west (robot-simulator:robot-bearing robot))))

(define-test move-west-and-south
  (let ((robot (robot-simulator:make-robot :position '(2 . -7) :bearing robot-simulator:east)))
    (robot-simulator:execute-sequence robot "RRAAAAALA")
    (assert-equal '(-3 . -8) (robot-simulator:robot-position robot))
    (assert-equal robot-simulator:south (robot-simulator:robot-bearing robot))))

(define-test move-east-and-north
  (let ((robot (robot-simulator:make-robot :position '(8 . 4) :bearing robot-simulator:south)))
    (robot-simulator:execute-sequence robot "LAAARRRALLLL")
    (assert-equal '(11 . 5) (robot-simulator:robot-position robot))
    (assert-equal robot-simulator:north (robot-simulator:robot-bearing robot))))

#-xlisp-test
(let ((*print-errors* t)
      (*print-failures* t))
  (run-tests :all :robot-simulator-test))
