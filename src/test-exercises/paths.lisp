(in-package #:test-exercises)

(defparameter +source-directory-pathname+
  (make-pathname :directory (pathname-directory
                             #.(or *compile-file-pathname* *load-pathname*)))
  "Location of this source of the TEST-EXERCISES system source code.
Location of other files in the common-lisp track will be found relative to this.")

(defun find-exercise-directory ()
  (merge-pathnames
   (make-pathname :directory (list :relative :up :up "exercises"))
   +source-directory-pathname+))

(defun list-exercise-directories (type)
  (directory (merge-pathnames
              (make-pathname :directory (list :relative type :wild))
              (find-exercise-directory))))
