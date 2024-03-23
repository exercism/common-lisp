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

(test first-generic-verse
    (let ((start-bottles 10)
          (take-down 1)
          (result '("Ten green bottles hanging on the wall," "Ten green bottles hanging on the wall," "And if one green bottle should accidentally fall," "There'll be nine green bottles hanging on the wall.")))
      (is (equal result (bottle-song:recite start-bottles take-down)))))

(test last-generic-verse
    (let ((start-bottles 3)
          (take-down 1)
          (result '("Three green bottles hanging on the wall," "Three green bottles hanging on the wall," "And if one green bottle should accidentally fall," "There'll be two green bottles hanging on the wall.")))
      (is (equal result (bottle-song:recite start-bottles take-down)))))

(test verse-with-2-bottles
    (let ((start-bottles 2)
          (take-down 1)
          (result '("Two green bottles hanging on the wall," "Two green bottles hanging on the wall," "And if one green bottle should accidentally fall," "There'll be one green bottle hanging on the wall.")))
      (is (equal result (bottle-song:recite start-bottles take-down)))))

(test verse-with-1-bottle
    (let ((start-bottles 1)
          (take-down 1)
          (result '("One green bottle hanging on the wall," "One green bottle hanging on the wall," "And if one green bottle should accidentally fall," "There'll be no green bottles hanging on the wall.")))
      (is (equal result (bottle-song:recite start-bottles take-down)))))

(test first-two-verses
    (let ((start-bottles 10)
          (take-down 2)
          (result '("Ten green bottles hanging on the wall," "Ten green bottles hanging on the wall," "And if one green bottle should accidentally fall," "There'll be nine green bottles hanging on the wall." "" "Nine green bottles hanging on the wall," "Nine green bottles hanging on the wall," "And if one green bottle should accidentally fall," "There'll be eight green bottles hanging on the wall.")))
      (is (equal result (bottle-song:recite start-bottles take-down)))))

(test last-three-verses
    (let ((start-bottles 3)
          (take-down 3)
          (result '("Three green bottles hanging on the wall," "Three green bottles hanging on the wall," "And if one green bottle should accidentally fall," "There'll be two green bottles hanging on the wall." "" "Two green bottles hanging on the wall," "Two green bottles hanging on the wall," "And if one green bottle should accidentally fall," "There'll be one green bottle hanging on the wall." "" "One green bottle hanging on the wall," "One green bottle hanging on the wall," "And if one green bottle should accidentally fall," "There'll be no green bottles hanging on the wall.")))
      (is (equal result (bottle-song:recite start-bottles take-down)))))

(test all-verses
    (let ((start-bottles 10)
          (take-down 10)
          (result '("Ten green bottles hanging on the wall," "Ten green bottles hanging on the wall," "And if one green bottle should accidentally fall," "There'll be nine green bottles hanging on the wall." "" "Nine green bottles hanging on the wall," "Nine green bottles hanging on the wall," "And if one green bottle should accidentally fall," "There'll be eight green bottles hanging on the wall." "" "Eight green bottles hanging on the wall," "Eight green bottles hanging on the wall," "And if one green bottle should accidentally fall," "There'll be seven green bottles hanging on the wall." "" "Seven green bottles hanging on the wall," "Seven green bottles hanging on the wall," "And if one green bottle should accidentally fall," "There'll be six green bottles hanging on the wall." "" "Six green bottles hanging on the wall," "Six green bottles hanging on the wall," "And if one green bottle should accidentally fall," "There'll be five green bottles hanging on the wall." "" "Five green bottles hanging on the wall," "Five green bottles hanging on the wall," "And if one green bottle should accidentally fall," "There'll be four green bottles hanging on the wall." "" "Four green bottles hanging on the wall," "Four green bottles hanging on the wall," "And if one green bottle should accidentally fall," "There'll be three green bottles hanging on the wall." "" "Three green bottles hanging on the wall," "Three green bottles hanging on the wall," "And if one green bottle should accidentally fall," "There'll be two green bottles hanging on the wall." "" "Two green bottles hanging on the wall," "Two green bottles hanging on the wall," "And if one green bottle should accidentally fall," "There'll be one green bottle hanging on the wall." "" "One green bottle hanging on the wall," "One green bottle hanging on the wall," "And if one green bottle should accidentally fall," "There'll be no green bottles hanging on the wall.")))
      (is (equal result (bottle-song:recite start-bottles take-down)))))

(defun run-tests (&optional (test-or-suite 'bottle-song-suite))
  "Provides human readable results of test run. Default to entire suite."
  (run! test-or-suite))
