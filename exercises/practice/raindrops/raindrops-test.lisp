;; Ensures that raindrops.lisp and the testing library are always loaded
(eval-when (:compile-toplevel :load-toplevel :execute)
  (load "raindrops")
  (quicklisp-client:quickload :fiveam))

;; Defines the testing package with symbols from raindrops and FiveAM in scope
;; The `run-tests` function is exported for use by both the user and test-runner
(defpackage :raindrops-test
  (:use :cl :fiveam)
  (:export :run-tests))

;; Enter the testing package
(in-package :raindrops-test)

;; Define and enter a new FiveAM test-suite
(def-suite* raindrops-suite)

(test test-1 (is (equal "1" (raindrops:convert 1))))

(test test-3 (is (equal "Pling" (raindrops:convert 3))))

(test test-5 (is (equal "Plang" (raindrops:convert 5))))

(test test-7 (is (equal "Plong" (raindrops:convert 7))))

(test test-6 (is (equal "Pling" (raindrops:convert 6))))

(test test-9 (is (equal "Pling" (raindrops:convert 9))))

(test test-10 (is (equal "Plang" (raindrops:convert 10))))

(test test-15 (is (equal "PlingPlang" (raindrops:convert 15))))

(test test-21 (is (equal "PlingPlong" (raindrops:convert 21))))

(test test-25 (is (equal "Plang" (raindrops:convert 25))))

(test test-35 (is (equal "PlangPlong" (raindrops:convert 35))))

(test test-49 (is (equal "Plong" (raindrops:convert 49))))

(test test-52 (is (equal "52" (raindrops:convert 52))))

(test test-105 (is (equal "PlingPlangPlong" (raindrops:convert 105))))

(test test-12121 (is (equal "12121" (raindrops:convert 12121))))

(defun run-tests (&optional (test-or-suite 'raindrops-suite))
  "Provides human readable results of test run. Default to entire suite."
  (run! test-or-suite))
