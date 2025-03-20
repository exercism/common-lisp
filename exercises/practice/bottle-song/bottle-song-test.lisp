;; Ensures that bottle-song.lisp and the testing library are always loaded
(eval-when (:compile-toplevel :load-toplevel :execute)
  (load "bottle-song")
  (quicklisp-client:quickload :fiveam))

;; Defines the testing package with symbols from bottle-song and FiveAM in scope
;; The `run-tests` function is exported for use by both the user and test-runner
(defpackage :bottle-song-test
  (:use :cl :fiveam)
  (:export :run-tests))

;; Enter the testing package
(in-package :bottle-song-test)

;; Define and enter a new FiveAM test-suite
(def-suite* bottle-song-suite)

(def-suite* verse :in bottle-song-suite)
(def-suite* single-verse :in verse)

(test first-generic-verse
  (is (equal '(
               "Ten green bottles hanging on the wall,"
               "Ten green bottles hanging on the wall,"
               "And if one green bottle should accidentally fall,"
               "There'll be nine green bottles hanging on the wall."
               )
             (bottle-song:recite 10 1))))

(test last-generic-verse
  (is (equal '(
               "Three green bottles hanging on the wall,"
               "Three green bottles hanging on the wall,"
               "And if one green bottle should accidentally fall,"
               "There'll be two green bottles hanging on the wall."
               )
             (bottle-song:recite 3 1))))

(test verse-with-two-bottles
  (is (equal '(
                "Two green bottles hanging on the wall,"
                "Two green bottles hanging on the wall,"
                "And if one green bottle should accidentally fall,"
                "There'll be one green bottle hanging on the wall."
               )
             (bottle-song:recite 2 1))))

(test verse-with-one-bottle
  (is (equal '(
               "One green bottle hanging on the wall,"
               "One green bottle hanging on the wall,"
               "And if one green bottle should accidentally fall,"
               "There'll be no green bottles hanging on the wall."
               )
             (bottle-song:recite 1 1))))

(def-suite* lyrics :in bottle-song-suite)
(def-suite* multiple-verses :in lyrics)

(test first-two-verses
  (is (equal '(
               "Ten green bottles hanging on the wall,"
               "Ten green bottles hanging on the wall,"
               "And if one green bottle should accidentally fall,"
               "There'll be nine green bottles hanging on the wall."
               ""
               "Nine green bottles hanging on the wall,"
               "Nine green bottles hanging on the wall,"
               "And if one green bottle should accidentally fall,"
               "There'll be eight green bottles hanging on the wall."
               )
             (bottle-song:recite 10 2))))

(test last-three-verses
  (is (equal '(
                "Three green bottles hanging on the wall,"
                "Three green bottles hanging on the wall,"
                "And if one green bottle should accidentally fall,"
                "There'll be two green bottles hanging on the wall."
                ""
                "Two green bottles hanging on the wall,"
                "Two green bottles hanging on the wall,"
                "And if one green bottle should accidentally fall,"
                "There'll be one green bottle hanging on the wall."
                ""
                "One green bottle hanging on the wall,"
                "One green bottle hanging on the wall,"
                "And if one green bottle should accidentally fall,"
                "There'll be no green bottles hanging on the wall."
               )
             (bottle-song:recite 3 3))))

(test all-verses
  (is (equal '(
                "Ten green bottles hanging on the wall,"
                "Ten green bottles hanging on the wall,"
                "And if one green bottle should accidentally fall,"
                "There'll be nine green bottles hanging on the wall."
                ""
                "Nine green bottles hanging on the wall,"
                "Nine green bottles hanging on the wall,"
                "And if one green bottle should accidentally fall,"
                "There'll be eight green bottles hanging on the wall."
                ""
                "Eight green bottles hanging on the wall,"
                "Eight green bottles hanging on the wall,"
                "And if one green bottle should accidentally fall,"
                "There'll be seven green bottles hanging on the wall."
                ""
                "Seven green bottles hanging on the wall,"
                "Seven green bottles hanging on the wall,"
                "And if one green bottle should accidentally fall,"
                "There'll be six green bottles hanging on the wall."
                ""
                "Six green bottles hanging on the wall,"
                "Six green bottles hanging on the wall,"
                "And if one green bottle should accidentally fall,"
                "There'll be five green bottles hanging on the wall."
                ""
                "Five green bottles hanging on the wall,"
                "Five green bottles hanging on the wall,"
                "And if one green bottle should accidentally fall,"
                "There'll be four green bottles hanging on the wall."
                ""
                "Four green bottles hanging on the wall,"
                "Four green bottles hanging on the wall,"
                "And if one green bottle should accidentally fall,"
                "There'll be three green bottles hanging on the wall."
                ""
                "Three green bottles hanging on the wall,"
                "Three green bottles hanging on the wall,"
                "And if one green bottle should accidentally fall,"
                "There'll be two green bottles hanging on the wall."
                ""
                "Two green bottles hanging on the wall,"
                "Two green bottles hanging on the wall,"
                "And if one green bottle should accidentally fall,"
                "There'll be one green bottle hanging on the wall."
                ""
                "One green bottle hanging on the wall,"
                "One green bottle hanging on the wall,"
                "And if one green bottle should accidentally fall,"
                "There'll be no green bottles hanging on the wall."
               )
             (bottle-song:recite 10 10))))


(defun run-tests (&optional (test-or-suite 'bottle-song-suite))
  "Provides human readable results of test run. Default to entire suite."
  (run! test-or-suite))
