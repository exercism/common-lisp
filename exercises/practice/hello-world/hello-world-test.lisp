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
  (print 'hello)
  (run! test-or-suite :print-names t))
