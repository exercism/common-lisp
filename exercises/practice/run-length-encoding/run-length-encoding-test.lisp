;; Ensures that run-length-encoding.lisp and the testing library are always loaded
(eval-when (:compile-toplevel :load-toplevel :execute)
  (load "run-length-encoding")
  (quicklisp-client:quickload :fiveam))

;; Defines the testing package with symbols from run-length-encoding and FiveAM in scope
;; The `run-tests` function is exported for use by both the user and test-runner
(defpackage :run-length-encoding-test
  (:use :cl :fiveam)
  (:export :run-tests))

;; Enter the testing package
(in-package :run-length-encoding-test)

;; Define and enter a new FiveAM test-suite
(def-suite* run-length-encoding-suite)

(test empty-string
    (let ((plain ""))
     (is (string= "" (run-length-encoding:encode plain)))))

(test single-characters-only-are-encoded-without-count
    (let ((plain "XYZ"))
     (is (string= "XYZ" (run-length-encoding:encode plain)))))

(test string-with-no-single-characters
    (let ((plain "AABBBCCCC"))
     (is (string= "2A3B4C" (run-length-encoding:encode plain)))))

(test single-characters-mixed-with-repeated-characters
    (let ((plain "WWWWWWWWWWWWBWWWWWWWWWWWWBBBWWWWWWWWWWWWWWWWWWWWWWWWB"))
     (is (string= "12WB12W3B24WB" (run-length-encoding:encode plain)))))

(test multiple-whitespace-mixed-in-string
    (let ((plain "  hsqq qww  "))
     (is (string= "2 hs2q q2w2 " (run-length-encoding:encode plain)))))

(test lowercase-characters
    (let ((plain "aabbbcccc"))
     (is (string= "2a3b4c" (run-length-encoding:encode plain)))))

(test empty-string
    (let ((compressed ""))
     (is (string= "" (run-length-encoding:decode compressed)))))

(test single-characters-only
    (let ((compressed "XYZ"))
     (is (string= "XYZ" (run-length-encoding:decode compressed)))))

(test string-with-no-single-characters
    (let ((compressed "2A3B4C"))
     (is (string= "AABBBCCCC" (run-length-encoding:decode compressed)))))

(test single-characters-with-repeated-characters
    (let ((compressed "12WB12W3B24WB"))
     (is (string= "WWWWWWWWWWWWBWWWWWWWWWWWWBBBWWWWWWWWWWWWWWWWWWWWWWWWB" (run-length-encoding:decode compressed)))))

(test multiple-whitespace-mixed-in-string
    (let ((compressed "2 hs2q q2w2 "))
     (is (string= "  hsqq qww  " (run-length-encoding:decode compressed)))))

(test lowercase-string
    (let ((compressed "2a3b4c"))
     (is (string= "aabbbcccc" (run-length-encoding:decode compressed)))))

(test encode-followed-by-decode-gives-original-string
    (let ((plain "zzz ZZ  zZ"))
     (is (string= plain (run-length-encoding:decode (run-length-encoding:encode plain))))))

(defun run-tests (&optional (test-or-suite 'run-length-encoding-suite))
  "Provides human readable results of test run. Default to entire suite."
  (run! test-or-suite))
