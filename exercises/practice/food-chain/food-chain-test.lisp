;; Ensures that food-chain.lisp and the testing library are always loaded
(eval-when (:compile-toplevel :load-toplevel :execute)
  (load "food-chain")
  (quicklisp-client:quickload :fiveam))

;; Defines the testing package with symbols from food-chain and FiveAM in scope
;; The `run-tests` function is exported for use by both the user and test-runner
(defpackage :food-chain-test
  (:use :cl :fiveam)
  (:export :run-tests))

;; Enter the testing package
(in-package :food-chain-test)

;; Define and enter a new FiveAM test-suite
(def-suite* food-chain-suite)

(test fly
    (let ((start-verse 1)
          (end-verse 1)
          (result (format nil "~{~A~^~%~}" '("I know an old lady who swallowed a fly."
                                             "I don't know why she swallowed the fly. Perhaps she'll die."))))
      (is (string= result (food-chain:recite start-verse end-verse)))))

(test spider
    (let ((start-verse 2)
          (end-verse 2)
          (result (format nil "~{~A~^~%~}" '("I know an old lady who swallowed a spider."
                                             "It wriggled and jiggled and tickled inside her."
                                             "She swallowed the spider to catch the fly."
                                             "I don't know why she swallowed the fly. Perhaps she'll die."))))
      (is (string= result (food-chain:recite start-verse end-verse)))))

(test bird
    (let ((start-verse 3)
          (end-verse 3)
          (result (format nil "~{~A~^~%~}" '("I know an old lady who swallowed a bird."
                                             "How absurd to swallow a bird!"
                                             "She swallowed the bird to catch the spider that wriggled and jiggled and tickled inside her."
                                             "She swallowed the spider to catch the fly."
                                             "I don't know why she swallowed the fly. Perhaps she'll die."))))
      (is (string= result (food-chain:recite start-verse end-verse)))))

(test cat
    (let ((start-verse 4)
          (end-verse 4)
          (result (format nil "~{~A~^~%~}" '("I know an old lady who swallowed a cat."
                                             "Imagine that, to swallow a cat!"
                                             "She swallowed the cat to catch the bird."
                                             "She swallowed the bird to catch the spider that wriggled and jiggled and tickled inside her."
                                             "She swallowed the spider to catch the fly."
                                             "I don't know why she swallowed the fly. Perhaps she'll die."))))
      (is (string= result (food-chain:recite start-verse end-verse)))))

(test dog
    (let ((start-verse 5)
          (end-verse 5)
          (result (format nil "~{~A~^~%~}" '("I know an old lady who swallowed a dog."
                                             "What a hog, to swallow a dog!"
                                             "She swallowed the dog to catch the cat."
                                             "She swallowed the cat to catch the bird."
                                             "She swallowed the bird to catch the spider that wriggled and jiggled and tickled inside her."
                                             "She swallowed the spider to catch the fly."
                                             "I don't know why she swallowed the fly. Perhaps she'll die."))))
      (is (string= result (food-chain:recite start-verse end-verse)))))

(test goat
    (let ((start-verse 6)
          (end-verse 6)
          (result (format nil "~{~A~^~%~}" '("I know an old lady who swallowed a goat."
                                             "Just opened her throat and swallowed a goat!"
                                             "She swallowed the goat to catch the dog."
                                             "She swallowed the dog to catch the cat."
                                             "She swallowed the cat to catch the bird."
                                             "She swallowed the bird to catch the spider that wriggled and jiggled and tickled inside her."
                                             "She swallowed the spider to catch the fly."
                                             "I don't know why she swallowed the fly. Perhaps she'll die."))))
      (is (string= result (food-chain:recite start-verse end-verse)))))

(test cow
    (let ((start-verse 7)
          (end-verse 7)
          (result (format nil "~{~A~^~%~}" '("I know an old lady who swallowed a cow."
                                             "I don't know how she swallowed a cow!"
                                             "She swallowed the cow to catch the goat."
                                             "She swallowed the goat to catch the dog."
                                             "She swallowed the dog to catch the cat."
                                             "She swallowed the cat to catch the bird."
                                             "She swallowed the bird to catch the spider that wriggled and jiggled and tickled inside her."
                                             "She swallowed the spider to catch the fly."
                                             "I don't know why she swallowed the fly. Perhaps she'll die."))))
      (is (string= result (food-chain:recite start-verse end-verse)))))

(test horse
    (let ((start-verse 8)
          (end-verse 8)
          (result (format nil "~{~A~^~%~}" '("I know an old lady who swallowed a horse."
                                             "She's dead, of course!"))))
      (is (string= result (food-chain:recite start-verse end-verse)))))

(test multiple-verses
    (let ((start-verse 1)
          (end-verse 3)
          (result (format nil "~{~A~^~%~}" '("I know an old lady who swallowed a fly."
                                             "I don't know why she swallowed the fly. Perhaps she'll die."
                                             ""
                                             "I know an old lady who swallowed a spider."
                                             "It wriggled and jiggled and tickled inside her."
                                             "She swallowed the spider to catch the fly."
                                             "I don't know why she swallowed the fly. Perhaps she'll die."
                                             ""
                                             "I know an old lady who swallowed a bird."
                                             "How absurd to swallow a bird!"
                                             "She swallowed the bird to catch the spider that wriggled and jiggled and tickled inside her."
                                             "She swallowed the spider to catch the fly."
                                             "I don't know why she swallowed the fly. Perhaps she'll die."))))
      (is (string= result (food-chain:recite start-verse end-verse)))))

(test full-song
    (let ((start-verse 1)
          (end-verse 8)
          (result (format nil "~{~A~^~%~}" '("I know an old lady who swallowed a fly."
                                             "I don't know why she swallowed the fly. Perhaps she'll die."
                                             ""
                                             "I know an old lady who swallowed a spider."
                                             "It wriggled and jiggled and tickled inside her."
                                             "She swallowed the spider to catch the fly."
                                             "I don't know why she swallowed the fly. Perhaps she'll die."
                                             ""
                                             "I know an old lady who swallowed a bird."
                                             "How absurd to swallow a bird!"
                                             "She swallowed the bird to catch the spider that wriggled and jiggled and tickled inside her."
                                             "She swallowed the spider to catch the fly."
                                             "I don't know why she swallowed the fly. Perhaps she'll die."
                                             ""
                                             "I know an old lady who swallowed a cat."
                                             "Imagine that, to swallow a cat!"
                                             "She swallowed the cat to catch the bird."
                                             "She swallowed the bird to catch the spider that wriggled and jiggled and tickled inside her."
                                             "She swallowed the spider to catch the fly."
                                             "I don't know why she swallowed the fly. Perhaps she'll die."
                                             ""
                                             "I know an old lady who swallowed a dog." "What a hog, to swallow a dog!"
                                             "She swallowed the dog to catch the cat."
                                             "She swallowed the cat to catch the bird."
                                             "She swallowed the bird to catch the spider that wriggled and jiggled and tickled inside her."
                                             "She swallowed the spider to catch the fly."
                                             "I don't know why she swallowed the fly. Perhaps she'll die."
                                             ""
                                             "I know an old lady who swallowed a goat."
                                             "Just opened her throat and swallowed a goat!"
                                             "She swallowed the goat to catch the dog."
                                             "She swallowed the dog to catch the cat."
                                             "She swallowed the cat to catch the bird."
                                             "She swallowed the bird to catch the spider that wriggled and jiggled and tickled inside her."
                                             "She swallowed the spider to catch the fly."
                                             "I don't know why she swallowed the fly. Perhaps she'll die."
                                             ""
                                             "I know an old lady who swallowed a cow."
                                             "I don't know how she swallowed a cow!"
                                             "She swallowed the cow to catch the goat."
                                             "She swallowed the goat to catch the dog."
                                             "She swallowed the dog to catch the cat."
                                             "She swallowed the cat to catch the bird."
                                             "She swallowed the bird to catch the spider that wriggled and jiggled and tickled inside her."
                                             "She swallowed the spider to catch the fly."
                                             "I don't know why she swallowed the fly. Perhaps she'll die."
                                             ""
                                             "I know an old lady who swallowed a horse."
                                             "She's dead, of course!"))))
      (is (string= result (food-chain:recite start-verse end-verse)))))

(defun run-tests (&optional (test-or-suite 'food-chain-suite))
  "Provides human readable results of test run. Default to entire suite."
  (run! test-or-suite))
