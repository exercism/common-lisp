(defpackage :house
  (:use :cl)
  (:export :recite))

(in-package :house)

(defparameter *verses*
  '("the house that Jack built."
    "the malt that lay in"
    "the rat that ate"
    "the cat that killed"
    "the dog that worried"
    "the cow with the crumpled horn that tossed"
    "the maiden all forlorn that milked"
    "the man all tattered and torn that kissed"
    "the priest all shaven and shorn that married"
    "the rooster that crowed in the morn that woke"
    "the farmer sowing his corn that kept"
    "the horse and the hound and the horn that belonged to"))

(defun build-verse (n)
  (let ((parts (reverse (subseq *verses* 0 n))))
    (format nil "This is ~{~A~^ ~}" parts)))

(defun recite (start-verse end-verse)
  (loop for verse from start-verse to end-verse
        collect (build-verse verse) into verses
        finally (return (format nil "~{~A~^~%~}" verses))))
