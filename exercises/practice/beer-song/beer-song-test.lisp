;; Ensures that beer-song.lisp and the testing library are always loaded
(eval-when (:compile-toplevel :load-toplevel :execute)
  (load "beer-song")
  (quicklisp-client:quickload :fiveam))

;; Defines the testing package with symbols from beer-song and FiveAM in scope
;; The `run-tests` function is exported for use by both the user and test-runner
(defpackage :beer-song-test
  (:use :cl :fiveam)
  (:export :run-tests))

;; Enter the testing package
(in-package :beer-song-test)

;; Define and enter a new FiveAM test-suite
(def-suite* beer-song-suite)

(defparameter +verse-0+
  (format nil
          "No more bottles of beer on the wall, no more bottles of beer.~&~
           Go to the store and buy some more, 99 bottles of beer on the wall.~&"))

(defparameter +verse-1+
  (format nil
          "1 bottle of beer on the wall, 1 bottle of beer.~&~
           Take it down and pass it around, no more bottles of beer on the wall.~&"))

(defparameter +verse-2+
  (format nil
          "2 bottles of beer on the wall, 2 bottles of beer.~&~
           Take one down and pass it around, 1 bottle of beer on the wall.~&"))

(defparameter +verse-8+
  (format nil
          "8 bottles of beer on the wall, 8 bottles of beer.~&~
           Take one down and pass it around, 7 bottles of beer on the wall.~&"))

(defparameter +song-3-0+
  (format nil
          "3 bottles of beer on the wall, 3 bottles of beer.~&~
           Take one down and pass it around, 2 bottles of beer on the wall.~&~
           ~%~
           2 bottles of beer on the wall, 2 bottles of beer.~&~
           Take one down and pass it around, 1 bottle of beer on the wall.~&~
           ~%~
           1 bottle of beer on the wall, 1 bottle of beer.~&~
           Take it down and pass it around, no more bottles of beer on the wall.~&~
           ~%~
           No more bottles of beer on the wall, no more bottles of beer.~&~
           Go to the store and buy some more, 99 bottles of beer on the wall.~&~
           ~%"))

(defparameter +song-8-6+
  (format nil
          "8 bottles of beer on the wall, 8 bottles of beer.~&~
           Take one down and pass it around, 7 bottles of beer on the wall.~&~
           ~%~
           7 bottles of beer on the wall, 7 bottles of beer.~&~
           Take one down and pass it around, 6 bottles of beer on the wall.~&~
           ~%~
           6 bottles of beer on the wall, 6 bottles of beer.~&~
           Take one down and pass it around, 5 bottles of beer on the wall.~&~
           ~%"))

(test test-verse (is (equal +verse-8+ (beer-song:verse 8)))
 (is (equal +verse-2+ (beer-song:verse 2)))
 (is (equal +verse-1+ (beer-song:verse 1))))

(test test-song (is (equal +song-8-6+ (beer-song:sing 8 6)))
 (is (equal +song-3-0+ (beer-song:sing 3))))

(defun run-tests (&optional (test-or-suite 'beer-song-suite))
  "Provides human readable results of test run. Default to entire suite."
  (run! test-or-suite))
