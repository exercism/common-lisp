;; Ensures that robot-simulator.lisp and the testing library are always loaded
(eval-when (:compile-toplevel :load-toplevel :execute)
  (load "robot-simulator")
  (quicklisp-client:quickload :fiveam))

;; Defines the testing package with symbols from robot-simulator and FiveAM in scope
;; The `run-tests` function is exported for use by both the user and test-runner
(defpackage :robot-simulator-test
  (:use :cl :fiveam)
  (:export :run-tests))

;; Enter the testing package
(in-package :robot-simulator-test)

;; Define and enter a new FiveAM test-suite
(def-suite* robot-simulator-suite)

(test robots-are-created-with-defaults
 (let ((robot (robot-simulator:make-robot)))
   (is (equal '(0 . 0) (robot-simulator:robot-position robot)))
   (is (equal robot-simulator:+north+ (robot-simulator:robot-bearing robot)))))

(test negative-coordinates-allowed
 (let ((robot
        (robot-simulator:make-robot :position '(-1 . -1) :bearing
         robot-simulator:+south+)))
   (is (equal '(-1 . -1) (robot-simulator:robot-position robot)))
   (is (equal robot-simulator:+south+ (robot-simulator:robot-bearing robot)))))

(test turn-right-north-to-east
 (let ((robot
        (robot-simulator:make-robot :position '(0 . 0) :bearing
         robot-simulator:+north+)))
   (robot-simulator:execute-sequence robot "R")
   (is (equal '(0 . 0) (robot-simulator:robot-position robot)))
   (is (equal robot-simulator:+east+ (robot-simulator:robot-bearing robot)))))

(test turn-right-east-to-south
 (let ((robot
        (robot-simulator:make-robot :position '(0 . 0) :bearing
         robot-simulator:+east+)))
   (robot-simulator:execute-sequence robot "R")
   (is (equal '(0 . 0) (robot-simulator:robot-position robot)))
   (is (equal robot-simulator:+south+ (robot-simulator:robot-bearing robot)))))

(test turn-right-south-to-west
 (let ((robot
        (robot-simulator:make-robot :position '(0 . 0) :bearing
         robot-simulator:+south+)))
   (robot-simulator:execute-sequence robot "R")
   (is (equal '(0 . 0) (robot-simulator:robot-position robot)))
   (is (equal robot-simulator:+west+ (robot-simulator:robot-bearing robot)))))

(test turn-right-west-to-north
 (let ((robot
        (robot-simulator:make-robot :position '(0 . 0) :bearing
         robot-simulator:+west+)))
   (robot-simulator:execute-sequence robot "R")
   (is (equal '(0 . 0) (robot-simulator:robot-position robot)))
   (is (equal robot-simulator:+north+ (robot-simulator:robot-bearing robot)))))

(test turn-left-north-to-west
 (let ((robot
        (robot-simulator:make-robot :position '(0 . 0) :bearing
         robot-simulator:+north+)))
   (robot-simulator:execute-sequence robot "L")
   (is (equal '(0 . 0) (robot-simulator:robot-position robot)))
   (is (equal robot-simulator:+west+ (robot-simulator:robot-bearing robot)))))

(test turn-left-west-to-south
 (let ((robot
        (robot-simulator:make-robot :position '(0 . 0) :bearing
         robot-simulator:+west+)))
   (robot-simulator:execute-sequence robot "L")
   (is (equal '(0 . 0) (robot-simulator:robot-position robot)))
   (is (equal robot-simulator:+south+ (robot-simulator:robot-bearing robot)))))

(test turn-left-south-to-east
 (let ((robot
        (robot-simulator:make-robot :position '(0 . 0) :bearing
         robot-simulator:+south+)))
   (robot-simulator:execute-sequence robot "L")
   (is (equal '(0 . 0) (robot-simulator:robot-position robot)))
   (is (equal robot-simulator:+east+ (robot-simulator:robot-bearing robot)))))

(test turn-left-east-to-north
 (let ((robot
        (robot-simulator:make-robot :position '(0 . 0) :bearing
         robot-simulator:+east+)))
   (robot-simulator:execute-sequence robot "L")
   (is (equal '(0 . 0) (robot-simulator:robot-position robot)))
   (is (equal robot-simulator:+north+ (robot-simulator:robot-bearing robot)))))

(test advance-increments-y-when-facing-north
 (let ((robot
        (robot-simulator:make-robot :position '(0 . 0) :bearing
         robot-simulator:+north+)))
   (robot-simulator:execute-sequence robot "A")
   (is (equal '(0 . 1) (robot-simulator:robot-position robot)))
   (is (equal robot-simulator:+north+ (robot-simulator:robot-bearing robot)))))

(test advance-decrements-y-when-facing-north
 (let ((robot
        (robot-simulator:make-robot :position '(0 . 0) :bearing
         robot-simulator:+south+)))
   (robot-simulator:execute-sequence robot "A")
   (is (equal '(0 . -1) (robot-simulator:robot-position robot)))
   (is (equal robot-simulator:+south+ (robot-simulator:robot-bearing robot)))))

(test advance-increments-x-when-facing-east
 (let ((robot
        (robot-simulator:make-robot :position '(0 . 0) :bearing
         robot-simulator:+east+)))
   (robot-simulator:execute-sequence robot "A")
   (is (equal '(1 . 0) (robot-simulator:robot-position robot)))
   (is (equal robot-simulator:+east+ (robot-simulator:robot-bearing robot)))))

(test advance-decrements-x-when-facing-west
 (let ((robot
        (robot-simulator:make-robot :position '(0 . 0) :bearing
         robot-simulator:+west+)))
   (robot-simulator:execute-sequence robot "A")
   (is (equal '(-1 . 0) (robot-simulator:robot-position robot)))
   (is (equal robot-simulator:+west+ (robot-simulator:robot-bearing robot)))))

(test move-east-and-north-readme
 (let ((robot
        (robot-simulator:make-robot :position '(7 . 3) :bearing
         robot-simulator:+north+)))
   (robot-simulator:execute-sequence robot "RAALAL")
   (is (equal '(9 . 4) (robot-simulator:robot-position robot)))
   (is (equal robot-simulator:+west+ (robot-simulator:robot-bearing robot)))))

(test move-west-and-north
 (let ((robot
        (robot-simulator:make-robot :position '(0 . 0) :bearing
         robot-simulator:+north+)))
   (robot-simulator:execute-sequence robot "LAAARALA")
   (is (equal '(-4 . 1) (robot-simulator:robot-position robot)))
   (is (equal robot-simulator:+west+ (robot-simulator:robot-bearing robot)))))

(test move-west-and-south
 (let ((robot
        (robot-simulator:make-robot :position '(2 . -7) :bearing
         robot-simulator:+east+)))
   (robot-simulator:execute-sequence robot "RRAAAAALA")
   (is (equal '(-3 . -8) (robot-simulator:robot-position robot)))
   (is (equal robot-simulator:+south+ (robot-simulator:robot-bearing robot)))))

(test move-east-and-north
 (let ((robot
        (robot-simulator:make-robot :position '(8 . 4) :bearing
         robot-simulator:+south+)))
   (robot-simulator:execute-sequence robot "LAAARRRALLLL")
   (is (equal '(11 . 5) (robot-simulator:robot-position robot)))
   (is (equal robot-simulator:+north+ (robot-simulator:robot-bearing robot)))))

(defun run-tests (&optional (test-or-suite 'robot-simulator-suite))
  "Provides human readable results of test run. Default to entire suite."
  (run! test-or-suite))
