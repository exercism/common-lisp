(defpackage :bob
  (:use :common-lisp)
  (:export :response))

(in-package :bob)

(defun contains-alpha-chars-p (msg)
  (some #'(lambda (c) (char-not-greaterp #\a c #\z))
        (coerce msg 'list)))

(defun silence-p (msg) (equal "" (string-trim '(#\Space #\Newline #\Tab #\Page) msg)))
(defun shouting-p (msg) (and (contains-alpha-chars-p msg)
                             (equal msg (string-upcase msg))))
(defun questioning-p (msg)
  (let ((msg (string-trim '(#\Space #\Newline #\Tab #\Page) msg)))
    (equal #\? (char msg (1- (length msg))))))

(defun response (msg)
  (cond ((silence-p msg) "Fine. Be that way!")
        ((and (shouting-p msg)
              (questioning-p msg)) "Calm down, I know what I'm doing!")
        ((shouting-p msg) "Whoa, chill out!")
        ((questioning-p msg) "Sure.")
        (t "Whatever.")))
