(ql:quickload "lisp-unit")
#-xlisp-test (load "twelve-days")

(defpackage #:twelve-days-test
  (:use #:common-lisp #:lisp-unit))

(in-package #:twelve-days-test)

(defvar verse1  "On the first day of Christmas my true love gave to me: a Partridge in a Pear Tree.")
(defvar verse2  "On the second day of Christmas my true love gave to me: two Turtle Doves, and a Partridge in a Pear Tree.")
(defvar verse3  "On the third day of Christmas my true love gave to me: three French Hens, two Turtle Doves, and a Partridge in a Pear Tree.")
(defvar verse4  "On the fourth day of Christmas my true love gave to me: four Calling Birds, three French Hens, two Turtle Doves, and a Partridge in a Pear Tree.")
(defvar verse5  "On the fifth day of Christmas my true love gave to me: five Gold Rings, four Calling Birds, three French Hens, two Turtle Doves, and a Partridge in a Pear Tree.")
(defvar verse6  "On the sixth day of Christmas my true love gave to me: six Geese-a-Laying, five Gold Rings, four Calling Birds, three French Hens, two Turtle Doves, and a Partridge in a Pear Tree.")
(defvar verse7  "On the seventh day of Christmas my true love gave to me: seven Swans-a-Swimming, six Geese-a-Laying, five Gold Rings, four Calling Birds, three French Hens, two Turtle Doves, and a Partridge in a Pear Tree.")
(defvar verse8  "On the eighth day of Christmas my true love gave to me: eight Maids-a-Milking, seven Swans-a-Swimming, six Geese-a-Laying, five Gold Rings, four Calling Birds, three French Hens, two Turtle Doves, and a Partridge in a Pear Tree.")
(defvar verse9  "On the ninth day of Christmas my true love gave to me: nine Ladies Dancing, eight Maids-a-Milking, seven Swans-a-Swimming, six Geese-a-Laying, five Gold Rings, four Calling Birds, three French Hens, two Turtle Doves, and a Partridge in a Pear Tree.")
(defvar verse10 "On the tenth day of Christmas my true love gave to me: ten Lords-a-Leaping, nine Ladies Dancing, eight Maids-a-Milking, seven Swans-a-Swimming, six Geese-a-Laying, five Gold Rings, four Calling Birds, three French Hens, two Turtle Doves, and a Partridge in a Pear Tree.")
(defvar verse11 "On the eleventh day of Christmas my true love gave to me: eleven Pipers Piping, ten Lords-a-Leaping, nine Ladies Dancing, eight Maids-a-Milking, seven Swans-a-Swimming, six Geese-a-Laying, five Gold Rings, four Calling Birds, three French Hens, two Turtle Doves, and a Partridge in a Pear Tree.")
(defvar verse12 "On the twelfth day of Christmas my true love gave to me: twelve Drummers Drumming, eleven Pipers Piping, ten Lords-a-Leaping, nine Ladies Dancing, eight Maids-a-Milking, seven Swans-a-Swimming, six Geese-a-Laying, five Gold Rings, four Calling Birds, three French Hens, two Turtle Doves, and a Partridge in a Pear Tree.")

(defun verse-mash (&rest verses)
  (format nil "~{~&~A~}" verses))

(define-test first_day_a_partridge_in_a_pear_tree
  (assert-equal verse1 (twelve-days:recite 1)))

(define-test second_day_two_turtle_doves
  (assert-equal verse2 (twelve-days:recite 2)))

(define-test third_day_three_french_hens
  (assert-equal verse3 (twelve-days:recite 3)))

(define-test fourth_day_four_calling_birds
  (assert-equal verse4 (twelve-days:recite 4)))

(define-test fifth_day_five_gold_rings
  (assert-equal verse5 (twelve-days:recite 5)))

(define-test sixth_day_six_geese_a_laying
  (assert-equal verse6 (twelve-days:recite 6)))

(define-test seventh_day_seven_swans_a_swimming
  (assert-equal verse7 (twelve-days:recite 7)))

(define-test eighth_day_eight_maids_a_milking
  (assert-equal verse8 (twelve-days:recite 8)))

(define-test ninth_day_nine_ladies_dancing
  (assert-equal verse9 (twelve-days:recite 9)))

(define-test tenth_day_ten_lords_a_leaping
  (assert-equal verse10 (twelve-days:recite 10)))

(define-test eleventh_day_eleven_pipers_piping
  (assert-equal verse11 (twelve-days:recite 11)))

(define-test twelfth_day_twelve_drummers_drumming
  (assert-equal verse12 (twelve-days:recite 12)))

(define-test recites_first_three_verses_of_the_song
  (assert-equal (verse-mash verse1 verse2 verse3)
                (twelve-days:recite 1 3)))

(define-test recites_three_verses_from_the_middle_of_the_song
  (assert-equal (verse-mash verse4 verse5 verse6)
                (twelve-days:recite 4 6)))

(define-test recites_the_whole_song
  (assert-equal (verse-mash verse1 verse2 verse3 verse4 verse5 verse6
                            verse7 verse8 verse9 verse10 verse11 verse12)
                (twelve-days:recite 1 12))
  (assert-equal (verse-mash verse1 verse2 verse3 verse4 verse5 verse6
                            verse7 verse8 verse9 verse10 verse11 verse12)
                (twelve-days:recite)))

#-xlisp-test
(let ((*print-errors* t)
      (*print-failures* t))
  (run-tests :all :twelve-days-test))
