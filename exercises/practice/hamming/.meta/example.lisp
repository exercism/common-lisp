(defpackage #:hamming
  (:use #:common-lisp)
  (:export #:distance))

(in-package #:hamming)

(defun distance (str1 str2 &key (test #'char=))
  "Number of positional differences in two equal length strings."
  (when (= (length str1) (length str2))
    (count nil
           (map 'list test str1 str2))))
