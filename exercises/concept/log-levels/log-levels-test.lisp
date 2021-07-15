;; Ensures that log-levels.lisp and the testing library are always loaded
(eval-when (:compile-toplevel :load-toplevel :execute)
  (load "log-levels")
  (ql:quickload :fiveam))

;; Defines the testing package with symbols from log-levels and FiveAM in scope
;; The `run-tests` function is exported for use by both the user and test-runner
(defpackage :log-levels-test
  (:use :cl :fiveam :log-levels)
  (:export :run-tests))

;; Enter the testing package
(in-package :log-levels-test)

;; Define and enter a new FiveAM test-suite
(def-suite log-levels-suite)
(in-suite log-levels-suite)

(test log-message "Retrieve the message from the log string"
      (is (string= "doing just fine" (log-message "[info]: doing just fine")))
      (is (string= "did you hear that?" (log-message "[warn]: did you hear that?")))
      (is (string= "we should be going" (log-message "[ohno]: we should be going"))))

(test log-severity "Determine the severity of the log string"
      (is (eq :everything-ok (log-severity "[info]: doing just fine")))
      (is (eq :getting-worried (log-severity "[warn]: did you hear that?")))
      (is (eq :run-for-cover (log-severity "[ohno]: we should be going"))))

(test log-severity-case-insensitive "Not all log strings follow the specification exactly"
      (is (eq :everything-ok (log-severity "[INFO]: doing just fine")))
      (is (eq :getting-worried (log-severity "[Warn]: did you hear that?")))
      (is (eq :run-for-cover (log-severity "[oHnO]: we should be going"))))

(test log-format "Format the log message according to the log severity"
      (is (string= "doing just fine" (log-format "[info]: DOING JUST FINE")))
      (is (string= "Did You Hear That?" (log-format "[warn]: did YOU hear THAT?")))
      (is (string= "WE SHOULD BE GOING" (log-format "[ohno]: we should be going"))))

(defun run-tests (&optional (test-or-suite 'log-levels-suite))
  "Provides human readable results of test run. Default to entire suite."
  (run! test-or-suite))
