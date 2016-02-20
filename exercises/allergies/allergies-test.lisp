(ql:quickload "lisp-unit")

(defpackage #:allergies-test
  (:use #:common-lisp #:lisp-unit))

#-xlisp-test (load "allergies")

(in-package #:allergies-test)

(define-test no-allergies-at-all
  (assert-equalp '() (allergies:list 0)))

(define-test allergic-to-just-eggs
  (assert-equalp '("eggs") (allergies:list 1)))

(define-test allergic-to-just-peanuts
  (assert-equalp '("peanuts") (allergies:list 2)))

(define-test allergic-to-just-strawberries
  (assert-equalp '("strawberries") (allergies:list 8)))

(define-test allergic-to-eggs-and-peanuts
  (assert-equalp '("eggs" "peanuts") (allergies:list 3)))

(define-test allergic-to-more-than-eggs-but-not-peanuts
  (assert-equalp '("eggs" "shellfish") (allergies:list 5)))

(define-test allergic-to-lots-of-stuff
  (assert-equalp
   '("strawberries" "tomatoes" "chocolate" "pollen" "cats")
   (allergies:list 248)))

(define-test allergic-to-everything
  (assert-equalp
   '("eggs" "peanuts" "shellfish" "strawberries" "tomatoes"
     "chocolate" "pollen" "cats")
   (allergies:list 255)))

(define-test no-allergies-means-not-allergic
  (assert-false (allergies:allergic-to-p 0 "peanuts"))
  (assert-false (allergies:allergic-to-p 0 "cats"))
  (assert-false (allergies:allergic-to-p 0 "strawberries")))

(define-test is-allergic-to-eggs
  (assert-true (allergies:allergic-to-p 1 "eggs")))

(define-test allergic-to-eggs-in-addition-to-other-stuff
  (assert-true (allergies:allergic-to-p 5 "eggs")))

(define-test ignore-non-allergen-score-parts
  (assert-equalp
   '("eggs" "shellfish" "strawberries" "tomatoes" "chocolate" "pollen"
     "cats")
   (allergies:list 509)))

#-xlisp-test
(let ((*print-errors* t)
      (*print-failures* t))
  (run-tests :all :allergies-test))
