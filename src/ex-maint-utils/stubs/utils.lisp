(in-package :stubs)

(defun relative-directory (&rest dirs)
  (make-pathname :directory `(:relative ,@dirs)))

(defun write-string-to-file (string pathname)
  (ensure-directories-exist pathname)
  (alexandria:write-string-into-file
   string pathname :if-exists :supersede :if-does-not-exist :create))

(defun file-in-dir (dir file) (merge-pathnames file dir))
(defun subdir (parent dir) (merge-pathnames (relative-directory dir) parent))

(defun recursive-listing (directory)
  (directory (merge-pathnames
              (make-pathname :directory '(:relative :wild-inferiors) :name :wild :type :wild)
              directory)))

(defparameter *github-username* "sir-not-appearing-in-this-film")

(defun github-username (stream format-argument colon-p at-sign-p &rest supplied-arguments)
  "FORMAT function to output the *GITHUB-USERNAME*"
  (declare (ignore format-argument colon-p at-sign-p supplied-arguments))
  (format stream "~S" *github-username*))

(defun format-template (template slug)
  (format nil template slug nil))
