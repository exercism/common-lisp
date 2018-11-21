(eval-when (:compile-toplevel :load-toplevel)
  (ql:quickload "cl-json"))

(in-package #:cl)

(defpackage #:exercise-data
  (:use #:cl)
  (:export #:read-exercise-data
           #:exercise-name
           #:exercise-version
           #:exercise-comments
           #:exercise-cases
           #:exercise-case-name
           #:exercise-case-function-info
           #:exercise-case-inputs
           #:exercise-case-expected))

(in-package :exercise-data)

(defun read-exercise-data (exercise-pathname)
  (with-open-file (stream exercise-pathname
                          :direction :input
                          :if-does-not-exist :error)
    (cl-json:decode-json-strict stream)))

(defun exercise-name (exercise-data)
  (cdr (assoc :exercise exercise-data)))

(defun exercise-comments (exercise-data)
  (cdr (assoc :comments exercise-data)))

(defun exercise-version (exercise-data)
  (cdr (assoc :version exercise-data)))

(defun exercise-cases (exercise-data)
  (cdr (assoc :cases exercise-data)))

(defun exercise-case-name (exercise-case)
  (cdr (assoc :description exercise-case)))

(defun exercise-case-function-info (exercise-case)
  (cons (intern (string-upcase (cdr (assoc :property exercise-case))) :keyword)
        (mapcar #'car (cdr (assoc :input exercise-case)))))

(defun exercise-case-inputs (exercise-case)
  (mapcar #'cdr (cdr (assoc :input exercise-case))))

(defun exercise-case-expected (exercise-case)
  (cdr (assoc :expected exercise-case)))
