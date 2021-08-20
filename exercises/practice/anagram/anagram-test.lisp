;; Ensures that anagram.lisp and the testing library are always loaded
(eval-when (:compile-toplevel :load-toplevel :execute)
  (load "anagram")
  (quicklisp-client:quickload :fiveam))

;; Defines the testing package with symbols from anagram and FiveAM in scope
;; The `run-tests` function is exported for use by both the user and test-runner
(defpackage :anagram-test
  (:use :cl :fiveam)
  (:export :run-tests))

;; Enter the testing package
(in-package :anagram-test)

;; Define and enter a new FiveAM test-suite
(def-suite* anagram-suite)

(test no-matches
 (is
  (equal 'nil
         (anagram:anagrams-for "diaper" '("hello" "world" "zombies" "pants")))))

(test detect-simple-anagram
 (is (equal '("tan") (anagram:anagrams-for "ant" '("tan" "stand" "at")))))

(test does-not-confuse-different-duplicates
 (is (equal 'nil (anagram:anagrams-for "galea" '("eagle")))))

(test eliminate-anagram-subsets
 (is (equal 'nil (anagram:anagrams-for "good" '("dog" "goody")))))

(test detect-anagram
 (is
  (equal '("inlets")
         (anagram:anagrams-for "listen"
                               '("enlists" "google" "inlets" "banana")))))

(test multiple-anagrams
 (is
  (equal '("gallery" "regally" "largely")
         (anagram:anagrams-for "allergy"
                               '("gallery" "ballerina" "regally" "clergy"
                                 "largely" "leading")))))

(test case-insensitive-anagrams
 (is
  (equal '("Carthorse")
         (anagram:anagrams-for "Orchestra"
                               '("cashregister" "Carthorse" "radishes")))))

(test word-is-not-own-anagram
 (is (equal 'nil (anagram:anagrams-for "banana" '("banana")))))

(test word-is-not-own-anagram-case-insensitively
 (is (equal 'nil (anagram:anagrams-for "bananarama" '("BananaRama")))))

(defun run-tests (&optional (test-or-suite 'anagram-suite))
  "Provides human readable results of test run. Default to entire suite."
  (run! test-or-suite))
