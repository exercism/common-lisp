;; Ensures that say.lisp and the testing library are always loaded
(eval-when (:compile-toplevel :load-toplevel :execute)
  (load "say")
  (quicklisp-client:quickload :fiveam))

;; Defines the testing package with symbols from say and FiveAM in scope
;; The `run-tests` function is exported for use by both the user and test-runner
(defpackage :say-test
  (:use :cl :fiveam)
  (:export :run-tests))

;; Enter the testing package
(in-package :say-test)

;; Define and enter a new FiveAM test-suite
(def-suite* say-suite)

(test zero
    (let ((number 0))
      (is (string= "zero" (say:say number)))))

(test one
    (let ((number 1))
      (is (string= "one" (say:say number)))))

(test fourteen
    (let ((number 14))
      (is (string= "fourteen" (say:say number)))))

(test twenty
    (let ((number 20))
      (is (string= "twenty" (say:say number)))))

(test twenty-two
    (let ((number 22))
      (is (string= "twenty-two" (say:say number)))))

(test thirty
    (let ((number 30))
      (is (string= "thirty" (say:say number)))))

(test ninety-nine
    (let ((number 99))
      (is (string= "ninety-nine" (say:say number)))))

(test one-hundred
    (let ((number 100))
      (is (string= "one hundred" (say:say number)))))

(test one-hundred-twenty-three
    (let ((number 123))
      (is (string= "one hundred twenty-three" (say:say number)))))

(test two-hundred
    (let ((number 200))
      (is (string= "two hundred" (say:say number)))))

(test nine-hundred-ninety-nine
    (let ((number 999))
      (is (string= "nine hundred ninety-nine" (say:say number)))))

(test one-thousand
    (let ((number 1000))
      (is (string= "one thousand" (say:say number)))))

(test one-thousand-two-hundred-thirty-four
    (let ((number 1234))
      (is (string= "one thousand two hundred thirty-four" (say:say number)))))

(test one-million
    (let ((number 1000000))
      (is (string= "one million" (say:say number)))))

(test one-million-two-thousand-three-hundred-forty-five
    (let ((number 1002345))
      (is (string= "one million two thousand three hundred forty-five" (say:say number)))))

(test one-billion
    (let ((number 1000000000))
      (is (string= "one billion" (say:say number)))))

(test a-big-number
    (let ((number 987654321123)
          (result "nine hundred eighty-seven billion six hundred fifty-four million three hundred twenty-one thousand one hundred twenty-three"))
      (is (string= result (say:say number)))))

(test numbers-below-zero-are-out-of-range
    (let ((number -1))
      (is (equal NIL (say:say number)))))

(test numbers-above-999999999999-are-out-of-range
    (let ((number 1000000000000))
      (is (equal NIL (say:say number)))))

(defun run-tests (&optional (test-or-suite 'say-suite))
  "Provides human readable results of test run. Default to entire suite."
  (run! test-or-suite))

