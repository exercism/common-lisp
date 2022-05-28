;; Ensures that rotational-cipher.lisp and the testing library are always loaded
(eval-when (:compile-toplevel :load-toplevel :execute)
  (load "rotational-cipher")
  (quicklisp-client:quickload :fiveam))

;; Defines the testing package with symbols from rotational-cipher and FiveAM in scope
;; The `run-tests` function is exported for use by both the user and test-runner
(defpackage :rotational-cipher-test
  (:use :cl :fiveam)
  (:export :run-tests))

;; Enter the testing package
(in-package :rotational-cipher-test)

;; Define and enter a new FiveAM test-suite
(def-suite* rotational-cipher-suite)

(test rotate-a-by-0-same-output-as-input
    (let ((text "a")
          (key 0))
      (is (string= "a" (rotational-cipher:rotate text key)))))

(test rotate-a-by-1
    (let ((text "a")
          (key 1))
      (is (string= "b" (rotational-cipher:rotate text key)))))

(test rotate-a-by-26-same-output-as-input
    (let ((text "a")
          (key 26))
      (is (string= "a" (rotational-cipher:rotate text key)))))

(test rotate-m-by-13
    (let ((text "m")
          (key 13))
      (is (string= "z" (rotational-cipher:rotate text key)))))

(test rotate-n-by-13-with-wrap-around-alphabet
    (let ((text "n")
          (key 13))
      (is (string= "a" (rotational-cipher:rotate text key)))))

(test rotate-capital-letters
    (let ((text "OMG")
          (key 5))
      (is (string= "TRL" (rotational-cipher:rotate text key)))))

(test rotate-spaces
    (let ((text "O M G")
          (key 5))
      (is (string= "T R L" (rotational-cipher:rotate text key)))))

(test rotate-numbers
    (let ((text "Testing 1 2 3 testing")
          (key 4))
      (is (string= "Xiwxmrk 1 2 3 xiwxmrk" (rotational-cipher:rotate text key)))))

(test rotate-punctuation
    (let ((text "Lets eat, Grandma!")
          (key 21))
      (is (string= "Gzon zvo, Bmviyhv!" (rotational-cipher:rotate text key)))))

(test rotate-all-letters
    (let ((text "The quick brown fox jumps over the lazy dog.")
          (key 13)
          (result "Gur dhvpx oebja sbk whzcf bire gur ynml qbt."))
      (is (string= result (rotational-cipher:rotate text key)))))

(defun run-tests (&optional (test-or-suite 'rotational-cipher-suite))
  "Provides human readable results of test run. Default to entire suite."
  (run! test-or-suite))
