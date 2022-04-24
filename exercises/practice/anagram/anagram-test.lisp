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
  (is (equal nil
             (anagram:anagrams-for "diaper" '("hello" "world" "zombies" "pants")))))

(test detects-two-anagrams
  (is (equal '("lemons" "melons")
             (anagram:anagrams-for "solemn" '("lemons" "cherry" "melons")))))

(test does-not-detect-anagram-subsets
  (is (equal nil (anagram:anagrams-for "good" '("dog" "goody")))))

(test detect-anagram
  (is (equal '("inlets")
             (anagram:anagrams-for "listen"
                                   '("enlists" "google" "inlets" "banana")))))

(test detects-three-anagrams
  (is (equal '("gallery" "regally" "largely")
             (anagram:anagrams-for "allergy"
                                   '("gallery" "ballerina" "regally" "clergy"
                                     "largely" "leading")))))

(test detects-multiple-anagrams-with-different-case
  (is (equal '("Eons" "ONES") (anagram:anagrams-for "nose" '("Eons" "ONES")))))

(test does-not-detect-non-anagrams-with-identical-checksum
  (is (equal nil (anagram:anagrams-for "mass" '("last")))))

(test detects-anagrams-case-insensitively
  (is (equal '("Carthorse")
             (anagram:anagrams-for "Orchestra"
                                   '("cashregister" "Carthorse" "radishes")))))

(test detects-anagrams-using-case-insensitive-subject
  (is (equal '("carthorse")
             (anagram:anagrams-for "Orchestra"
                                   '("cashregister" "carthorse" "radishes")))))

(test detects-anagrams-using-case-insensitive-possible-matches
  (is (equal '("Carthorse")
             (anagram:anagrams-for "orchestra"
                                   '("cashregister" "Carthorse" "radishes")))))

(test does-not-detect-an-anagram-if-the-original-word-is-repeated
  (is (equal nil (anagram:anagrams-for "go" '("go" "Go" "GO")))))

(test anagrams-must-use-all-letters-exactly-once
  (is (equal nil (anagram:anagrams-for "tapper" '("patter")))))

(test words-are-not-anagrams-of-themselves
  (is (equal nil (anagram:anagrams-for "BANANA" '("BANANA")))))

(test words-are-not-anagrams-of-themselves-even-if-letter-case-is-partially-different
  (is (equal nil (anagram:anagrams-for "BANANA" '("Banana"))))  )

(test words-are-not-anagrams-of-themselves-even-if-letter-case-is-completely-different
  (is (equal nil (anagram:anagrams-for "BANANA" '("banana"))))  )

(test words-other-than-themselves-can-be-anagrams
  (is (equal '("Silent") (anagram:anagrams-for "LISTEN" '("LISTEN" "Silent")))))


(defun run-tests (&optional (test-or-suite 'anagram-suite))
  "Provides human readable results of test run. Default to entire suite."
  (run! test-or-suite))
