(defpackage :food-chain
  (:use :cl)
  (:export :recite))

(in-package :food-chain)

(defparameter +creatures+ #("fly" "spider" "bird" "cat" "dog" "goat" "cow" "horse"))
(defparameter +unique-lines+ #("I don't know why she swallowed the fly. Perhaps she'll die."
                               "It wriggled and jiggled and tickled inside her."
                               "How absurd to swallow a bird!"
                               "Imagine that, to swallow a cat!"
                               "What a hog, to swallow a dog!"
                               "Just opened her throat and swallowed a goat!"
                               "I don't know how she swallowed a cow!"
                               "She's dead, of course!"))

(defun verse-end-p (index)
  (or (= 7 index) (zerop index)))

(defun add-lines (index)
  (if (verse-end-p index)
    (list (concatenate 'string (aref +unique-lines+ index) '(#\newline)))
    (let* ((spider (if (= 2 index) " that wriggled and jiggled and tickled inside her" ""))
           (creature (aref +creatures+ index))
           (next-creature (aref +creatures+ (1- index)))
           (line (format nil "She swallowed the ~A to catch the ~A~A.~%" creature next-creature spider)))
      (cons line (add-lines (1- index))))))

(defun single-verse (index)
  (let ((verse-block (reduce (lambda (x y) (concatenate 'string x y)) (add-lines index)))
        (start-line (format nil "I know an old lady who swallowed a ~A.~%" (aref +creatures+ index)))
        (second-line (unless (verse-end-p index) (concatenate 'string (aref +unique-lines+ index) '(#\newline)))))
      (string-right-trim '(#\newline) (concatenate 'string start-line second-line verse-block))))

(defun recite (start-verse end-verse)
  (loop for index from (1- start-verse) below end-verse
    collect (single-verse index) into output
    finally (return (format nil "~{~A~^~2%~}" output))))
