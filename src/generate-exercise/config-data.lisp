(defpackage :config-data
  (:use :common-lisp)
  (:shadow :read :write)
  (:export :*config-pathname*
           :read
           :write
           :get-exercise
           :|(setf get-exercise)|
           :add-exercise
           :remove-exercise))

(in-package :config-data)

(defvar *config-pathname*  (make-pathname :name "config" :type "json"))

(defun read (&optional (file *config-pathname*))
  (with-open-file (stream file :direction :input :if-does-not-exist :error)
    (cl-json:decode-json-strict stream)))

(defun write (data &optional (file *config-pathname*))
  (with-open-file (stream file :direction :output :if-exists :supersede)
    (cl-json:encode-json data stream))
  (configlet:format))

(defun slug-matches-p (name)
  #'(lambda (exercise) (string= (cdr (assoc :slug exercise)) name)))

(defun get-exercise (name data)
  (find-if (slug-matches-p name)
           (cdr (assoc :exercises data))))

(defun (setf get-exercise) (new-value name data)
  (setf (cdr (assoc :exercises data))
        (nsubstitute-if new-value (slug-matches-p name)
                        (cdr (assoc :exercises data)))))

(defun add-exercise (exercise-info data)
  (setf (cdr (assoc :exercises data))
        (append (cdr (assoc :exercises data))
                (list exercise-info))))

(defun remove-exercise (name data)
  (setf (cdr (assoc :exercises data))
        (remove-if
         #'(lambda (exercise) (let ((slug (cdr (assoc :slug exercise)))) (string= name slug)))
         (cdr (assoc :exercises data)))))
