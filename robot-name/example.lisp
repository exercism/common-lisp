(defpackage #:robot
  (:use #:common-lisp)
  (:export #:build-robot #:robot-name #:reset-name #:robot))

(in-package #:robot)

(defparameter *robot-names* (make-hash-table :test #'equal))

(defclass robot ()
    ((name :initarg :name :accessor robot-name)))

(defun build-robot ()
  (make-instance 'robot :name (unique-random-name)))

(defun unique-random-name ()
  (loop
     for name = (random-name)
     when (unique-name-p name) do
       (store-name name)
       (return name)))

(defun random-name ()
  (format nil "~c~c~3,'0d"
          (random-letter)
          (random-letter)
          (random 1000)))

(defun random-letter ()
  (let ((A (char-code #\A))
        (Z (char-code #\Z)))
    (code-char (+ A (random (- Z A))))))

(defun unique-name-p (name)
  (null (gethash name *robot-names*)))

(defun store-name (name)
  (setf (gethash name *robot-names*) t))

(defun reset-name (robot)
  (with-slots (name) robot
    (setf name (unique-random-name))))
