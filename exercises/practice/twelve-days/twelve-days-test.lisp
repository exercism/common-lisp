;; Ensures that twelve-days.lisp and the testing library are always loaded
(eval-when (:compile-toplevel :load-toplevel :execute)
  (load "twelve-days")
  (quicklisp-client:quickload :fiveam))

;; Defines the testing package with symbols from twelve-days and FiveAM in scope
;; The `run-tests` function is exported for use by both the user and test-runner
(defpackage :twelve-days-test
  (:use :cl :fiveam)
  (:export :run-tests))

;; Enter the testing package
(in-package :twelve-days-test)

;; Define and enter a new FiveAM test-suite
(def-suite* twelve-days-suite)

(defvar verse1
  "On the first day of Christmas my true love gave to me: a Partridge in a Pear Tree.")

(defvar verse2
  "On the second day of Christmas my true love gave to me: two Turtle Doves, and a Partridge in a Pear Tree.")

(defvar verse3
  "On the third day of Christmas my true love gave to me: three French Hens, two Turtle Doves, and a Partridge in a Pear Tree.")

(defvar verse4
  "On the fourth day of Christmas my true love gave to me: four Calling Birds, three French Hens, two Turtle Doves, and a Partridge in a Pear Tree.")

(defvar verse5
  "On the fifth day of Christmas my true love gave to me: five Gold Rings, four Calling Birds, three French Hens, two Turtle Doves, and a Partridge in a Pear Tree.")

(defvar verse6
  "On the sixth day of Christmas my true love gave to me: six Geese-a-Laying, five Gold Rings, four Calling Birds, three French Hens, two Turtle Doves, and a Partridge in a Pear Tree.")

(defvar verse7
  "On the seventh day of Christmas my true love gave to me: seven Swans-a-Swimming, six Geese-a-Laying, five Gold Rings, four Calling Birds, three French Hens, two Turtle Doves, and a Partridge in a Pear Tree.")

(defvar verse8
  "On the eighth day of Christmas my true love gave to me: eight Maids-a-Milking, seven Swans-a-Swimming, six Geese-a-Laying, five Gold Rings, four Calling Birds, three French Hens, two Turtle Doves, and a Partridge in a Pear Tree.")

(defvar verse9
  "On the ninth day of Christmas my true love gave to me: nine Ladies Dancing, eight Maids-a-Milking, seven Swans-a-Swimming, six Geese-a-Laying, five Gold Rings, four Calling Birds, three French Hens, two Turtle Doves, and a Partridge in a Pear Tree.")

(defvar verse10
  "On the tenth day of Christmas my true love gave to me: ten Lords-a-Leaping, nine Ladies Dancing, eight Maids-a-Milking, seven Swans-a-Swimming, six Geese-a-Laying, five Gold Rings, four Calling Birds, three French Hens, two Turtle Doves, and a Partridge in a Pear Tree.")

(defvar verse11
  "On the eleventh day of Christmas my true love gave to me: eleven Pipers Piping, ten Lords-a-Leaping, nine Ladies Dancing, eight Maids-a-Milking, seven Swans-a-Swimming, six Geese-a-Laying, five Gold Rings, four Calling Birds, three French Hens, two Turtle Doves, and a Partridge in a Pear Tree.")

(defvar verse12
  "On the twelfth day of Christmas my true love gave to me: twelve Drummers Drumming, eleven Pipers Piping, ten Lords-a-Leaping, nine Ladies Dancing, eight Maids-a-Milking, seven Swans-a-Swimming, six Geese-a-Laying, five Gold Rings, four Calling Birds, three French Hens, two Turtle Doves, and a Partridge in a Pear Tree.")

(defun verse-mash (&rest verses) (format nil "~{~&~A~}" verses))

(test first_day_a_partridge_in_a_pear_tree
 (is (equal verse1 (twelve-days:recite 1))))

(test second_day_two_turtle_doves (is (equal verse2 (twelve-days:recite 2))))

(test third_day_three_french_hens (is (equal verse3 (twelve-days:recite 3))))

(test fourth_day_four_calling_birds (is (equal verse4 (twelve-days:recite 4))))

(test fifth_day_five_gold_rings (is (equal verse5 (twelve-days:recite 5))))

(test sixth_day_six_geese_a_laying (is (equal verse6 (twelve-days:recite 6))))

(test seventh_day_seven_swans_a_swimming
 (is (equal verse7 (twelve-days:recite 7))))

(test eighth_day_eight_maids_a_milking
 (is (equal verse8 (twelve-days:recite 8))))

(test ninth_day_nine_ladies_dancing (is (equal verse9 (twelve-days:recite 9))))

(test tenth_day_ten_lords_a_leaping
 (is (equal verse10 (twelve-days:recite 10))))

(test eleventh_day_eleven_pipers_piping
 (is (equal verse11 (twelve-days:recite 11))))

(test twelfth_day_twelve_drummers_drumming
 (is (equal verse12 (twelve-days:recite 12))))

(test recites_first_three_verses_of_the_song
 (is (equal (verse-mash verse1 verse2 verse3) (twelve-days:recite 1 3))))

(test recites_three_verses_from_the_middle_of_the_song
 (is (equal (verse-mash verse4 verse5 verse6) (twelve-days:recite 4 6))))

(test recites_the_whole_song
 (is
  (equal
   (verse-mash verse1 verse2 verse3 verse4 verse5 verse6 verse7 verse8 verse9
    verse10 verse11 verse12)
   (twelve-days:recite 1 12)))
 (is
  (equal
   (verse-mash verse1 verse2 verse3 verse4 verse5 verse6 verse7 verse8 verse9
    verse10 verse11 verse12)
   (twelve-days:recite))))

(defun run-tests (&optional (test-or-suite 'twelve-days-suite))
  "Provides human readable results of test run. Default to entire suite."
  (run! test-or-suite))
