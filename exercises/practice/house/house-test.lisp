;; Ensures that house.lisp and the testing library are always loaded
(eval-when (:compile-toplevel :load-toplevel :execute)
  (load "house")
  (quicklisp-client:quickload :fiveam))

;; Defines the testing package with symbols from house and FiveAM in scope
;; The `run-tests` function is exported for use by both the user and test-runner
(defpackage :house-test
  (:use :cl :fiveam)
  (:export :run-tests))

;; Enter the testing package
(in-package :house-test)

;; Define and enter a new FiveAM test-suite
(def-suite* house-suite)

(test verse-one-the-house-that-jack-built
  (is (equal "This is the house that Jack built." (house:recite 1 1))))

(test verse-two-the-malt-that-lay
  (is (equal "This is the malt that lay in the house that Jack built."
             (house:recite 2 2))))

(test verse-three-the-rat-that-ate
  (let* ((fragments '("This is the rat"
                      "that ate the malt"
                      "that lay in the house"
                      "that Jack built."))
         (formatted (format nil "~{~A~^ ~}" fragments)))
    (is (equal formatted (house:recite 3 3)))))

(test verse-four-the-cat-that-killed
  (let* ((fragments '("This is the cat"
                      "that killed the rat"
                      "that ate the malt"
                      "that lay in the house"
                      "that Jack built."))
         (formatted (format nil "~{~A~^ ~}" fragments)))
    (is (equal formatted (house:recite 4 4)))))

(test verse-five-the-dog-that-worried
  (let* ((fragments '("This is the dog"
                      "that worried the cat"
                      "that killed the rat"
                      "that ate the malt"
                      "that lay in the house"
                      "that Jack built."))
         (formatted (format nil "~{~A~^ ~}" fragments)))
    (is (equal formatted (house:recite 5 5)))))

(test verse-six-the-cow-with-the-crumpled-horn
  (let* ((fragments '("This is the cow with the crumpled horn"
                      "that tossed the dog"
                      "that worried the cat"
                      "that killed the rat"
                      "that ate the malt"
                      "that lay in the house"
                      "that Jack built."))
         (formatted (format nil "~{~A~^ ~}" fragments)))
    (is (equal formatted (house:recite 6 6)))))

(test verse-seven-the-maiden-all-forlorn
  (let* ((fragments '("This is the maiden all forlorn"
                      "that milked the cow with the crumpled horn"
                      "that tossed the dog"
                      "that worried the cat"
                      "that killed the rat"
                      "that ate the malt"
                      "that lay in the house"
                      "that Jack built."))
         (formatted (format nil "~{~A~^ ~}" fragments)))
    (is (equal formatted (house:recite 7 7)))))

(test verse-eight-the-man-all-tattered-and-torn
  (let* ((fragments '("This is the man all tattered and torn"
                      "that kissed the maiden all forlorn"
                      "that milked the cow with the crumpled horn"
                      "that tossed the dog"
                      "that worried the cat"
                      "that killed the rat"
                      "that ate the malt"
                      "that lay in the house"
                      "that Jack built."))
         (formatted (format nil "~{~A~^ ~}" fragments)))
    (is (equal formatted (house:recite 8 8)))))

(test verse-nine-the-priest-all-shaven-and-shorn
  (let* ((fragments '("This is the priest all shaven and shorn"
                      "that married the man all tattered and torn"
                      "that kissed the maiden all forlorn"
                      "that milked the cow with the crumpled horn"
                      "that tossed the dog"
                      "that worried the cat"
                      "that killed the rat"
                      "that ate the malt"
                      "that lay in the house"
                      "that Jack built."))
          (formatted (format nil "~{~A~^ ~}" fragments)))
    (is (equal formatted (house:recite 9 9)))))

(test verse-ten-the-rooster-that-crowed-in-the-morn
  (let* ((fragments '("This is the rooster that crowed in the morn"
                      "that woke the priest all shaven and shorn"
                      "that married the man all tattered and torn"
                      "that kissed the maiden all forlorn"
                      "that milked the cow with the crumpled horn"
                      "that tossed the dog"
                      "that worried the cat"
                      "that killed the rat"
                      "that ate the malt"
                      "that lay in the house"
                      "that Jack built."))
          (formatted (format nil "~{~A~^ ~}" fragments)))
    (is (equal formatted (house:recite 10 10)))))

(test verse-eleven-the-farmer-sowing-his-corn
  (let* ((fragments '("This is the farmer sowing his corn"
                      "that kept the rooster that crowed in the morn"
                      "that woke the priest all shaven and shorn"
                      "that married the man all tattered and torn"
                      "that kissed the maiden all forlorn"
                      "that milked the cow with the crumpled horn"
                      "that tossed the dog"
                      "that worried the cat"
                      "that killed the rat"
                      "that ate the malt"
                      "that lay in the house"
                      "that Jack built."))
          (formatted (format nil "~{~A~^ ~}" fragments)))
    (is (equal formatted (house:recite 11 11)))))

(test verse-twelve-the-horse-and-the-hound-and-the-horn
  (let* ((fragments '("This is the horse and the hound and the horn"
                      "that belonged to the farmer sowing his corn"
                      "that kept the rooster that crowed in the morn"
                      "that woke the priest all shaven and shorn"
                      "that married the man all tattered and torn"
                      "that kissed the maiden all forlorn"
                      "that milked the cow with the crumpled horn"
                      "that tossed the dog"
                      "that worried the cat"
                      "that killed the rat"
                      "that ate the malt"
                      "that lay in the house"
                      "that Jack built."))
          (formatted (format nil "~{~A~^ ~}" fragments)))
    (is (equal formatted (house:recite 12 12)))))

(test multiple-verses
  (let* ((fourth-verse (format nil "~{~A~^ ~}"
                                   '("This is the cat that killed the rat"
                                     "that ate the malt"
                                     "that lay in the house"
                                     "that Jack built.")))
         (fifth-verse (format nil "~{~A~^ ~}"
                                  '("This is the dog that worried the cat"
                                    "that killed the rat"
                                    "that ate the malt"
                                    "that lay in the house"
                                    "that Jack built.")))
         (sixth-verse (format nil "~{~A~^ ~}"
                                  '("This is the cow with the crumpled horn"
                                    "that tossed the dog that worried the cat"
                                    "that killed the rat"
                                    "that ate the malt"
                                    "that lay in the house"
                                    "that Jack built.")))
         (seventh-verse (format nil "~{~A~^ ~}"
                                    '("This is the maiden all forlorn"
                                      "that milked the cow with the crumpled horn"
                                      "that tossed the dog that worried the cat"
                                      "that killed the rat"
                                      "that ate the malt"
                                      "that lay in the house"
                                      "that Jack built.")))
         (eighth-verse (format nil "~{~A~^ ~}"
                                   '("This is the man all tattered and torn"
                                     "that kissed the maiden all forlorn"
                                     "that milked the cow with the crumpled horn"
                                     "that tossed the dog that worried the cat"
                                     "that killed the rat"
                                     "that ate the malt"
                                     "that lay in the house"
                                     "that Jack built.")))
         (formatted (format nil "~{~A~^~%~}"
                                (list fourth-verse fifth-verse
                                      sixth-verse seventh-verse
                                      eighth-verse))))
    (is (equal formatted (house:recite 4 8)))))

(test full-rhyme
  (let* ((first-verse "This is the house that Jack built.")
         (second-verse (format nil "~{~A~^ ~}"
                                   '("This is the malt that lay in the house"
                                     "that Jack built.")))
         (third-verse (format nil "~{~A~^ ~}"
                                  '("This is the rat that ate the malt"
                                    "that lay in the house"
                                    "that Jack built.")))
         (fourth-verse (format nil "~{~A~^ ~}"
                                   '("This is the cat that killed the rat"
                                     "that ate the malt"
                                     "that lay in the house"
                                     "that Jack built.")))
         (fifth-verse (format nil "~{~A~^ ~}"
                                  '("This is the dog that worried the cat"
                                    "that killed the rat"
                                    "that ate the malt"
                                    "that lay in the house"
                                    "that Jack built.")))
         (sixth-verse (format nil "~{~A~^ ~}"
                                   '("This is the cow with the crumpled horn"
                                     "that tossed the dog that worried the cat"
                                     "that killed the rat"
                                     "that ate the malt"
                                     "that lay in the house"
                                     "that Jack built.")))
         (seventh-verse (format nil "~{~A~^ ~}"
                                     '("This is the maiden all forlorn"
                                       "that milked the cow with the crumpled horn"
                                       "that tossed the dog that worried the cat"
                                       "that killed the rat"
                                       "that ate the malt"
                                       "that lay in the house"
                                       "that Jack built.")))
         (eighth-verse (format nil "~{~A~^ ~}"
                                    '("This is the man all tattered and torn"
                                      "that kissed the maiden all forlorn"
                                      "that milked the cow with the crumpled horn"
                                      "that tossed the dog that worried the cat"
                                      "that killed the rat"
                                      "that ate the malt"
                                      "that lay in the house"
                                      "that Jack built.")))
          (ninth-verse (format nil "~{~A~^ ~}"
                                    '("This is the priest all shaven and shorn"
                                      "that married the man all tattered and torn"
                                      "that kissed the maiden all forlorn"
                                      "that milked the cow with the crumpled horn"
                                      "that tossed the dog that worried the cat"
                                      "that killed the rat"
                                      "that ate the malt"
                                      "that lay in the house"
                                      "that Jack built.")))
          (tenth-verse (format nil "~{~A~^ ~}"
                                    '("This is the rooster that crowed in the morn"
                                      "that woke the priest all shaven and shorn"
                                      "that married the man all tattered and torn"
                                      "that kissed the maiden all forlorn"
                                      "that milked the cow with the crumpled horn"
                                      "that tossed the dog that worried the cat"
                                      "that killed the rat"
                                      "that ate the malt"
                                      "that lay in the house"
                                      "that Jack built.")))
          (eleventh-verse (format nil "~{~A~^ ~}"
                                      '("This is the farmer sowing his corn"
                                        "that kept the rooster that crowed in the morn"
                                        "that woke the priest all shaven and shorn"
                                        "that married the man all tattered and torn"
                                        "that kissed the maiden all forlorn"
                                        "that milked the cow with the crumpled horn"
                                        "that tossed the dog that worried the cat"
                                        "that killed the rat"
                                        "that ate the malt"
                                        "that lay in the house"
                                        "that Jack built.")))
          (twelfth-verse (format nil "~{~A~^ ~}"
                                     '("This is the horse and the hound and the horn"
                                       "that belonged to the farmer sowing his corn"
                                       "that kept the rooster that crowed in the morn"
                                       "that woke the priest all shaven and shorn"
                                       "that married the man all tattered and torn"
                                       "that kissed the maiden all forlorn"
                                       "that milked the cow with the crumpled horn"
                                       "that tossed the dog that worried the cat"
                                       "that killed the rat"
                                       "that ate the malt"
                                       "that lay in the house"
                                       "that Jack built.")))
          (formatted (format nil "~{~A~^~%~}"
                                    (list first-verse second-verse third-verse
                                          fourth-verse fifth-verse sixth-verse
                                          seventh-verse eighth-verse ninth-verse
                                          tenth-verse eleventh-verse twelfth-verse))))
    (is (equal formatted (house:recite 1 12)))))

(defun run-tests (&optional (test-or-suite 'house-suite))
  "Provides human readable results of test run. Default to entire suite."
  (run! test-or-suite))
