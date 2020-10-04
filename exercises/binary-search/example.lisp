(in-package #:cl-user)
(defpackage #:binary-search
  (:use #:common-lisp)
  (:export #:binary-find #:value-error))

(in-package #:binary-search)

(define-condition value-error (error)
  ())

(defun binary-find (arr el)
  (loop
    with low = 0
    with high = (1- (length arr))
    for mid = (truncate (+ low high) 2)
    while (<= low high) do
      (cond
	((> (aref arr mid) el)
	 (setf high (1- mid)))
	((< (aref arr mid) el)
	 (setf low (1+ mid)))
	(t (return mid)))
    finally (error 'value-error)))
