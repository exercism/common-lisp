;; Ensures that eliuds-eggs.lisp and the testing library are always loaded
(eval-when (:compile-toplevel :load-toplevel :execute)
  (load "eliuds-eggs")
  (quicklisp-client:quickload :fiveam))

;; Defines the testing package with symbols from eliuds-eggs and FiveAM in scope
;; The `run-tests` function is exported for use by both the user and test-runner
(defpackage :eliuds-eggs-test
  (:use :cl :fiveam)
  (:export :run-tests))

;; Enter the testing package
(in-package :eliuds-eggs-test)

;; Define and enter a new FiveAM test-suite
(def-suite* eliuds-eggs-suite)

(test 0-eggs
    (let ((number 0))
      (is (= 0 (eliuds-eggs:egg-count number)))))

(test 1-egg
    (let ((number 16))
      (is (= 1 (eliuds-eggs:egg-count number)))))

(test 4-eggs
    (let ((number 89))
      (is (= 4 (eliuds-eggs:egg-count number)))))

(test 13-eggs
    (let ((number 2000000000))
      (is (= 13 (eliuds-eggs:egg-count number)))))

(defun run-tests (&optional (test-or-suite 'eliuds-eggs-suite))
  "Provides human readable results of test run. Default to entire suite."
  (run! test-or-suite))
