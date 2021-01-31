(ql:quickload "lisp-unit")
#-xlisp-test (load "beer-song")

(defpackage #:beer-song-test
  (:use #:common-lisp #:lisp-unit))

(in-package #:beer-song-test)

(defparameter +verse-8+
  (format nil
          "8 bottles of beer on the wall, 8 bottles of beer.~&~
           Take one down and pass it around, 7 bottles of beer on the wall.~&"))
(defparameter +verse-2+
  (format nil
          "2 bottles of beer on the wall, 2 bottles of beer.~&~
           Take one down and pass it around, 1 bottle of beer on the wall.~&"))
(defparameter +verse-1+
  (format nil
          "1 bottle of beer on the wall, 1 bottle of beer.~&~
           Take it down and pass it around, no more bottles of beer on the wall.~&"))
(defparameter +verse-0+
  (format nil
          "No more bottles of beer on the wall, no more bottles of beer.~&~
           Go to the store and buy some more, 99 bottles of beer on the wall.~&"))

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

(define-test test-verse
  (assert-equal +verse-8+ (beer-song:verse 8))
  (assert-equal +verse-2+ (beer-song:verse 2))
  (assert-equal +verse-1+ (beer-song:verse 1)))

(define-test test-song
  (assert-equal +song-8-6+ (beer-song:sing 8 6))
  (assert-equal +song-3-0+ (beer-song:sing 3)))

#-xlisp-test
(let ((*print-errors* t)
      (*print-failures* t))
  (run-tests :all :beer-song-test))
