(defpackage #:xlisp-test
  (:use #:cl #:lisp-unit)
  (:export #:run-tests-all
           #:excluded-pathname-p
           #:example-packages-p
           #:test-packages-p
           #:problems-p))

(in-package #:xlisp-test)

;;; Optional messaging

(defparameter *verbosity* nil
  "Verbosity of feedback.

- 1 :: warn
- 2 :: info
- 4 :: debug")

(defun verbosity-p (level)
  (check-type level integer)
  (not (zerop (logand level *verbosity*))))

(defun notice (level datum &rest arguments)
  (when (verbosity-p level)
    (format t datum (values-list arguments))))

(defun alert (message)
  (notice 1 "ALERT: ~A" message))

(defun inform (message)
  (notice 2 "INFO: ~A" message))


;;; Managing paths and packages

(defparameter *excluded-paths* '("bin" "docs")
  "Pathnames in xlisp to exclude from test search")

(defun excluded-pathname-p (pathname)
  "Identify an excluded pathname."
  (let ((exclusions (map 'list
                         (lambda (path)
                           (truename (make-pathname :directory (list :relative path))))
                         *excluded-paths*)))
    (find (truename pathname) exclusions :test #'pathname-match-p)))

(defun list-test-files (name)
  "List files matching `name' in non-excluded subdirectories."
  (if (wild-pathname-p name)
      (setf name (pathname name))
      (setf name (make-pathname :name name :type "lisp")))
  (remove-if #'excluded-pathname-p
             (directory (merge-pathnames
                         name
                         (make-pathname :directory '(:relative :wild))))
             :key #'directory-namestring))


;;; Load example exercises

(defparameter *example-files*
  (list-test-files "example")
  "All example files.")

(defparameter *example-packages*
  ()
  "All example packages")

(defun example-packages-p ()
  "What, if any, example packages have been defined?"
  *example-packages*)

(defun load-examples ()
  "Load example files, record new packages in `*example-packages'."
  (inform "Loading examples...")
  (let ((packages-before (list-all-packages)))
    (dolist (file *example-files*)
      (load file :verbose (verbosity-p 2) :print (verbosity-p 2)))
    (setf *example-packages*
          (set-difference (list-all-packages) packages-before))))


;;; Load exercise tests, record packages

(defparameter *test-packages*
  ()
  "List of test packages.")

(defun test-packages-p ()
  "What, if any, test packages are defined?"
  *test-packages*)

(defparameter *test-files*
  (list-test-files (pathname "*-test.lisp"))
  ;; Hack to get SBCL (possibly others) to interpret wildcard
  ;; filenames as they would.
  "All test files.")

(defun load-test-files ()
  "Load test files, record new packages in `*test-packages*'."
  (pushnew :xlisp-test *features*)
  (inform "Loading test files...")
  (let ((packages-before (list-all-packages)))
    (dolist (file *test-files*)
      (load file :verbose t :print t))
    (setf *test-packages*
          (set-difference (list-all-packages) packages-before))))


;;; Define collection of problematic test results

(defparameter *problems*
  ()
  "Record of failed or errored test results")

(defun problems-p ()
  "What tests were problematic, if any?"
  *problems*)

(defun record-problem (result)
  "Record problem test result."
  (alert "Recording problem")
  (pushnew result *problems*))

(defun delete-all-problems ()
  "Clear all problem test results."
  (inform "Deleting problems...")
  (setf *problems* ()))


;;; Define lisp-unit test handling

(defun handle-results (results)
  "Handle lisp-unit's test-run-complete signal."
  (when (failed-tests results)
    (print-failures results)
    (record-problem results))
  (when (error-tests results)
    (print-errors results)
    (record-problem results)))


;;; Define test runner

(defun run-tests-all (&optional (verbosity 2))
  "Run all tests."
  (setf *verbosity* verbosity)
  (inform (format nil "Verbosity level: ~D" *verbosity*))
  (inform "Running all xlisp tests...")
  (or *example-packages* (load-examples))
  (or *test-packages* (load-test-files))
  (and (problems-p) (delete-all-problems))
  (dolist (package *test-packages* (problems-p))
    (handler-bind ((test-run-complete
                    (lambda (condition)
                      (handle-results (results condition)))))
      (signal-results)
      (inform (format nil "Running tests in ~S" package))
      (run-tests :all package))))
