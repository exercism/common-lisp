;; Ensures that reporting-for-duty.lisp and the testing library are always loaded
(eval-when (:compile-toplevel :load-toplevel :execute)
  (load "reporting-for-duty")
  (ql:quickload :fiveam))

;; Defines the testing package with symbols from reporting-for-duty and FiveAM in scope
;; The `run-tests` function is exported for use by both the user and test-runner
(defpackage :reporting-for-duty-test
  (:use :cl :fiveam :reporting-for-duty)
  (:export :run-tests))

;; Enter the testing package
(in-package :reporting-for-duty-test)

;; Define and enter a new FiveAM test-suite
(def-suite reporting-for-duty-suite)
(in-suite reporting-for-duty-suite)

(test format-quarter-value "report on the value for the given quarter"
  (is (string= "The value next quarter: A"
               (format-quarter-value "next" 'a)))
  (is (string= "The value previous quarter: (1 2 3)"
               (format-quarter-value "previous" '(1 2 3)))))

(test format-two-quarters-string "report on value of two quarters written to a string"
  (is (string=
       "
The value next quarter: (1 2 3)
The value previous quarter: A
"
       (format-two-quarters nil "next" '(1 2 3) "previous" 'a))))

(test format-two-quarters-stream "report on value of two quarters written to a stream"
  (is (string=
       "
The value last quarter: 5
The value next quarter: -2
"
       (with-output-to-string (stream)
         (format-two-quarters stream "last" 5 "next" -2)))))

(test format-two-quarters-stdout "report on value of two quarters written to standard output"
  (is (string=
       "
The value penultimate quarter: 13
The value ultimate quarter: NIL
"
       (with-output-to-string (stream)
         (let ((*standard-output* stream))
           (format-two-quarters stream "penultimate" 13 "ultimate" nil))))))

(test format-readable-string "produce a readable report to a string"
  (is (string=
       "(\"The value next quarter: (1 2 3)\" \"The value previous quarter: A\")"
       (format-two-quarters-for-reading nil "next" '(1 2 3) "previous" 'a))))


(test format-readable-stream "produce a readable report to a stream"
  (is (string=
       "(\"The value last quarter: 5\" \"The value next quarter: -2\")"
       (with-output-to-string (stream)
         (format-two-quarters-for-reading stream "last" 5 "next" -2)))))

(test format-readable-stdout "produce a readable report to standard output"
  (is (string=
       "(\"The value penultimate quarter: 13\" \"The value ultimate quarter: NIL\")"
       (with-output-to-string (stream)
         (let ((*standard-output* stream))
           (format-two-quarters-for-reading stream "penultimate" 13 "ultimate" nil))))))

(defun run-tests (&optional (test-or-suite 'reporting-for-duty-suite))
  "Provides human readable results of test run. Default to entire suite."
  (run! test-or-suite))
