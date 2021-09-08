(in-package :stubs)

(defun relative-directory (&rest dirs)
  (make-pathname :directory `(:relative ,@dirs)))

(defun file-in-dir (dir file) (merge-pathnames file dir))
(defun subdir (parent dir) (merge-pathnames (relative-directory dir) parent))

(defun recursive-listing (directory)
  (directory (merge-pathnames
              (make-pathname :directory '(:relative :wild-inferiors) :name :wild :type :wild)
              directory)))

(defparameter *github-username* "sir-not-appearing-in-this-film")

(defun format-to-file (pathname string &rest args)
  "Applies FORMAT to STRING and ARGS and outputs it to PATHNAME.
Will overwrite PATHNAME if it already exists.
Ensures directories leading to PATHNAME exist."
  (ensure-directories-exist pathname)
  (with-open-file (stream pathname :direction :output :if-exists :supersede)
    (apply #'format stream string args)))
