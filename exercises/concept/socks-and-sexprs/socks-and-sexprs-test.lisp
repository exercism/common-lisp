;; Ensures that socks-and-sexprs.lisp and the testing library are always loaded
(eval-when (:compile-toplevel :load-toplevel :execute)
  (load "socks-and-sexprs")
  (ql:quickload :fiveam))

;; Defines the testing package with symbols from socks-and-sexprs and FiveAM in scope
;; The `run-tests` function is exported for use by both the user and test-runner
(defpackage :socks-and-sexprs-test
  (:use :cl :fiveam :socks-and-sexprs)
  (:export :run-tests))

;; Enter the testing package
(in-package :socks-and-sexprs-test)

;; Define and enter a new FiveAM test-suite
(def-suite socks-and-sexprs-suite)
(in-suite socks-and-sexprs-suite)

(test symbols "Lenny's favorite food is a non-null symbol"
  (is-true (symbolp (lennys-favorite-food)))
  (is-false (null (lennys-favorite-food)))
  (is-false (keywordp (lennys-favorite-food))))

(test keywords "Lenny's secret keyword is a keyword"
  (is-true (keywordp (lennys-secret-keyword))))

(test atoms "Lenny can recognise atoms"
  (is-true (is-an-atom-p 5))
  (is-true (is-an-atom-p 5.5))
  (is-true (is-an-atom-p 'a))
  (is-true (is-an-atom-p "hello"))
  (is-true (is-an-atom-p t))
  (is-true (is-an-atom-p :a-keyword))
  (is-true (is-an-atom-p #'atom))
  (is-true (is-an-atom-p #'consp))
  (is-true (is-an-atom-p nil))
  (is-false (is-an-atom-p '(1 2 3)))
  (is-false (is-an-atom-p '(a . b)))
  (is-false (is-an-atom-p (list 1 2 3)))
  (is-false (is-an-atom-p (cons 'a 'b))))

(test conses "Lenny can recognise conses"
  (is-true (is-a-cons-p '(a . b)))
  (is-true (is-a-cons-p (cons 'a 'b)))
  (is-true (is-a-cons-p (list 1 2 3)))
  (is-false (is-a-cons-p 5))
  (is-false (is-a-cons-p 5.5))
  (is-false (is-a-cons-p 'a))
  (is-false (is-a-cons-p "hello"))
  (is-false (is-a-cons-p t))
  (is-false (is-a-cons-p :a-keyword))
  (is-false (is-a-cons-p #'atom))
  (is-false (is-a-cons-p #'consp))
  (is-false (is-a-cons-p nil)))

(test first "Lenny can get the first item of a cons"
  (is (equal 'a (first-thing (cons 'a 'b))))
  (is (equal 'a (first-thing (list 'a 'b)))))

(test rest "Lenny can get the rest of a cons"
  (is (equal 'b (rest-of-it (cons 'a 'b))))
  (is (equal '(b) (rest-of-it (cons 'a (cons 'b nil)))))
  (is (equal '(b) (rest-of-it (list 'a 'b))))
  (is (equal nil (rest-of-it (cons 'a nil))))
  (is (equal nil (rest-of-it (list 'a)))))

(defun run-tests (&optional (test-or-suite 'socks-and-sexprs-suite))
  "Provides human readable results of test run. Default to entire suite."
  (run! test-or-suite))
