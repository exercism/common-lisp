;; Ensures that robot-name.lisp and the testing library are always loaded
(eval-when (:compile-toplevel :load-toplevel :execute)
  (load "robot-name")
  (quicklisp-client:quickload :fiveam))

;; Defines the testing package with symbols from robot-name and FiveAM in scope
;; The `run-tests` function is exported for use by both the user and test-runner
(defpackage :robot-name-test
  (:use :cl :fiveam)
  (:export :run-tests))

;; Enter the testing package
(in-package :robot-name-test)

;; Define and enter a new FiveAM test-suite
(def-suite* robot-name-suite)

(test name-matches-expected-pattern
  (let* ((robbie (robot-name:build-robot))
         (name (robot-name:robot-name robbie)))
   (is (= 5 (length name)))
   (is (every #'upper-case-p (subseq name 0 2)))
   (is (every #'digit-char-p (subseq name 2 5)))))

(test name-is-persistent
  (let ((robbie (robot-name:build-robot)))
   (is (equal (robot-name:robot-name robbie) (robot-name:robot-name robbie)))))

(test different-robots-have-different-names
  (let ((robbie (robot-name:build-robot))
        (clutz (robot-name:build-robot)))
   (is (not (equal (robot-name:robot-name clutz)
                   (robot-name:robot-name robbie))))))

(test name-can-be-reset
 (let* ((robot (robot-name:build-robot))
        (original-name (robot-name:robot-name robot)))
   (robot-name:reset-name robot)
   (is (not (equal (robot-name:robot-name robot) original-name)))))

(defun run-tests (&optional (test-or-suite 'robot-name-suite))
  "Provides human readable results of test run. Default to entire suite."
  (run! test-or-suite))
