;; Ensures that crypto-square.lisp and the testing library are always loaded
(eval-when (:compile-toplevel :load-toplevel :execute)
  (load "crypto-square")
  (quicklisp-client:quickload :fiveam))

;; Defines the testing package with symbols from crypto-square and FiveAM in scope
;; The `run-tests` function is exported for use by both the user and test-runner
(defpackage :crypto-square-test
  (:use :cl :fiveam)
  (:export :run-tests))

;; Enter the testing package
(in-package :crypto-square-test)

;; Define and enter a new FiveAM test-suite
(def-suite* crypto-square-suite)

(test empty-plaintext-results-in-an-empty-ciphertext
 (is (equal "" (crypto-square:encipher ""))))

(test normalization-results-in-empty-plaintext
 (is (equal "" (crypto-square:encipher "... --- ..."))))

(test lowercase (is (equal "a" (crypto-square:encipher "A"))))

(test remove-spaces (is (equal "b" (crypto-square:encipher "  b "))))

(test remove-punctuation (is (equal "1" (crypto-square:encipher "@1,%!"))))

(test 9-character-plaintext-results-in-3-chunks-of-3-characters
 (is (equal "tsf hiu isn" (crypto-square:encipher "This is fun!"))))

(test
 8-character-plaintext-results-in-3-chunks-the-last-one-with-a-trailing-space
 (is (equal "clu hlt io " (crypto-square:encipher "Chill out."))))

(test
 54-character-plaintext-results-in-7-chunks-the-last-two-with-trailing-spaces
 (is
  (equal "imtgdvs fearwer mayoogo anouuio ntnnlvt wttddes aohghn  sseoau "
         (crypto-square:encipher
          "If man was meant to stay on the ground, god would have given us roots."))))

(defun run-tests (&optional (test-or-suite 'crypto-square-suite))
  "Provides human readable results of test run. Default to entire suite."
  (run! test-or-suite))

