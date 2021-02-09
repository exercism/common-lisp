(in-package #:cl-user)
(defpackage #:twelve-days
  (:use #:cl)
  (:export #:recite))

(in-package #:twelve-days)

(defvar *gifts*
  (nreverse
  '("a Partridge in a Pear Tree."
    "two Turtle Doves"
    "three French Hens"
    "four Calling Birds"
    "five Gold Rings"
    "six Geese-a-Laying"
    "seven Swans-a-Swimming"
    "eight Maids-a-Milking"
    "nine Ladies Dancing"
    "ten Lords-a-Leaping"
    "eleven Pipers Piping"
    "twelve Drummers Drumming")))

(defvar *day-of-christmas-str*
  "On the ~A day of Christmas my true love gave to me: ~A")

(defvar *place*
  '("first"
    "second"
    "third"
    "fourth"
    "fifth"
    "sixth"
    "seventh"
    "eighth"
    "ninth"
    "tenth"
    "eleventh"
    "twelfth"))

(defun recite (&optional begin end)
  (let ((begin (or begin 1))
        (end   (if begin
                   (or end begin)
                   12))
        song-list)
    (dotimes (num (1+ (- end begin)))
      (setf song-list
            (cons (recite-verse (+ num begin))
                  song-list)))
    (format nil "~{~&~A~}" (nreverse song-list))))

(defun recite-verse (num)
  (format nil *day-of-christmas-str*
    (nth (1- num) *place*)
    (if (= num 1)
        (car (last *gifts*))
        (format nil "~{~A, ~}and ~A"
                (butlast (nthcdr (- 12 num) *gifts*))
                (car (last *gifts*))))))
