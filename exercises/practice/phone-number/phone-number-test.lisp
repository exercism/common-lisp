;; Ensures that phone-number.lisp and the testing library are always loaded
(eval-when (:compile-toplevel :load-toplevel :execute)
  (load "phone-number")
  (quicklisp-client:quickload :fiveam))

;; Defines the testing package with symbols from phone-number and FiveAM in scope
;; The `run-tests` function is exported for use by both the user and test-runner
(defpackage :phone-number-test
  (:use :cl :fiveam)
  (:export :run-tests))

;; Enter the testing package
(in-package :phone-number-test)

;; Define and enter a new FiveAM test-suite
(def-suite* phone-number-suite)

(test cleans-number
      (is (string= "2234567890" (phone-number:clean "(223) 456-7890"))))

(test cleans-number-with-dots
      (is (string= "2234567890" (phone-number:clean "223.456.7890"))))

(test cleans-number-with-multiple-spaces
      (is (string= "2234567890" (phone-number:clean "223 456   7890   "))))

(test invalid-when-9-digits
      (is (string= "0000000000" (phone-number:clean "123456789"))))

(test invalid-when-11-digits-does-not-start-with-a-1
      (is (string= "0000000000" (phone-number:clean "22234567890"))))

(test valid-when-11-digits-and-starting-with-1
      (is (string= "2234567890" (phone-number:clean "12234567890"))))

(test valid-when-11-digits-and-starting-with-1-even-with-punctuation
      (is (string= "2234567890" (phone-number:clean "+1 (223) 456-7890"))))

(test invalid-when-more-than-11-digits
      (is (string= "0000000000" (phone-number:clean "321234567890"))))

(test invalid-with-letters
      (is (string= "0000000000" (phone-number:clean "523-abc-7890"))))

(test invalid-with-punctuations
      (is (string= "0000000000" (phone-number:clean "523-@:!-7890"))))

(test invalid-if-area-code-starts-with-0
      (is (string= "0000000000" (phone-number:clean "(023) 456-7890"))))

(test invalid-if-area-code-starts-with-1
      (is (string= "0000000000" (phone-number:clean "(123) 456-7890"))))

(test invalid-if-exchange-code-starts-with-0
      (is (string= "0000000000" (phone-number:clean "(223) 056-7890"))))

(test invalid-if-exchange-code-starts-with-1
      (is (string= "0000000000" (phone-number:clean "(223) 156-7890"))))

(test invalid-if-area-code-starts-with-0-on-valid-11-digit-number
      (is (string= "0000000000" (phone-number:clean "1 (023) 456-7890"))))

(test invalid-if-area-code-starts-with-1-on-valid-11-digit-number
      (is (string= "0000000000" (phone-number:clean "1 (123) 456-7890"))))

(test invalid-if-exchange-code-starts-with-0-on-valid-11-digit-number
      (is (string= "0000000000" (phone-number:clean "1 (223) 056-7890"))))

(test invalid-if-exchange-code-starts-with-1-on-valid-11-digit-number
      (is (string= "0000000000" (phone-number:clean "1 (223) 156-7890"))))

(defun run-tests (&optional (test-or-suite 'phone-number-suite))
  "Provides human readable results of test run. Default to entire suite."
  (run! test-or-suite))
