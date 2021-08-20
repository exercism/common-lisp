;; Ensures that hello-world.lisp and the testing library are always loaded
(eval-when (:compile-toplevel :load-toplevel :execute)
  (load "hello-world")
  (quicklisp-client:quickload :fiveam))

;; Defines the testing package with symbols from hello-world and FiveAM in scope
;; The `run-tests` function is exported for use by both the user and test-runner
(defpackage :hello-world-test
  (:use :cl :fiveam)
  (:export :run-tests))

;; Enter the testing package
(in-package :hello-world-test)

;; Define and enter a new FiveAM test-suite
(def-suite* hello-world-suite)

(test say-hi! (is (equal "Hello, World!" (hello-world:hello))))

(defun run-tests (&optional (test-or-suite 'hello-world-suite))
  "Provides human readable results of test run. Default to entire suite."
  (run! test-or-suite))
