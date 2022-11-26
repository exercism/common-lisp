(defpackage :socks-and-sexprs
  (:use :cl)
  (:export :lennys-favorite-food :lennys-secret-keyword
           :is-an-atom-p :is-a-cons-p :first-thing :rest-of-it))

(in-package :socks-and-sexprs)

;; Evaluates to some symbol (not a keyword)
(defun lennys-favorite-food ()
  ;; put your symbol here
  )

;; Evaluates to some keyword
(defun lennys-secret-keyword ()
  ;; put your keyword here
  )

;; Evaluates to T if THING is an atom, NIL otherwise
(defun is-an-atom-p (thing)
  ;; put the code to determine if THING is an atom here
  )

;; Evaluates to T if THING is a cons, NIL otherwise
(defun is-a-cons-p (thing)
  ;; put the code to determine if THING is a CONS here
  )

;; Evaluates to the first part of CONS
(defun first-thing (cons)
  ;; put the code to get the first part of CONS here
  )

;; Evaluates to the 'rest' of the CONS
(defun rest-of-it (cons)
  ;; put the code to get the rest of CONS here
  )
