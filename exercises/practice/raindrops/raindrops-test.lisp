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

(test the-sound-for-1-is-1
    (let ((number 1))
      (is (string= "1" (raindrops:convert number)))))

(test the-sound-for-3-is-pling
    (let ((number 3))
      (is (string= "Pling" (raindrops:convert number)))))

(test the-sound-for-5-is-plang
    (let ((number 5))
      (is (string= "Plang" (raindrops:convert number)))))

(test the-sound-for-7-is-plong
    (let ((number 7))
      (is (string= "Plong" (raindrops:convert number)))))

(test the-sound-for-6-is-pling-as-it-has-a-factor-3
    (let ((number 6))
      (is (string= "Pling" (raindrops:convert number)))))

(test 2-to-the-power-3-does-not-make-a-raindrop-sound-as-3-is-the-exponent-not-the-base
    (let ((number 8))
      (is (string= "8" (raindrops:convert number)))))

(test the-sound-for-9-is-pling-as-it-has-a-factor-3
    (let ((number 9))
      (is (string= "Pling" (raindrops:convert number)))))

(test the-sound-for-10-is-plang-as-it-has-a-factor-5
    (let ((number 10))
      (is (string= "Plang" (raindrops:convert number)))))

(test the-sound-for-14-is-plong-as-it-has-a-factor-of-7
    (let ((number 14))
      (is (string= "Plong" (raindrops:convert number)))))

(test the-sound-for-15-is-plingplang-as-it-has-factors-3-and-5
    (let ((number 15))
      (is (string= "PlingPlang" (raindrops:convert number)))))

(test the-sound-for-21-is-plingplong-as-it-has-factors-3-and-7
    (let ((number 21))
      (is (string= "PlingPlong" (raindrops:convert number)))))

(test the-sound-for-25-is-plang-as-it-has-a-factor-5
    (let ((number 25))
      (is (string= "Plang" (raindrops:convert number)))))

(test the-sound-for-27-is-pling-as-it-has-a-factor-3
    (let ((number 27))
      (is (string= "Pling" (raindrops:convert number)))))

(test the-sound-for-35-is-plangplong-as-it-has-factors-5-and-7
    (let ((number 35))
      (is (string= "PlangPlong" (raindrops:convert number)))))

(test the-sound-for-49-is-plong-as-it-has-a-factor-7
    (let ((number 49))
      (is (string= "Plong" (raindrops:convert number)))))

(test the-sound-for-52-is-52
    (let ((number 52))
      (is (string= "52" (raindrops:convert number)))))

(test the-sound-for-105-is-plingplangplong-as-it-has-factors-3-5-and-7
    (let ((number 105))
      (is (string= "PlingPlangPlong" (raindrops:convert number)))))

(test the-sound-for-3125-is-plang-as-it-has-a-factor-5
    (let ((number 3125))
      (is (string= "Plang" (raindrops:convert number)))))

(defun run-tests (&optional (test-or-suite 'raindrops-suite))
  "Provides human readable results of test run. Default to entire suite."
  (run! test-or-suite))
