(ql:quickload "lisp-unit" :silent t)
(ql:quickload "uiop" :silent t)
(ql:quickload "cl-json" :silent t)

(defpackage #:xlisp-test
  (:use #:cl)
  (:export #:test-exercise
           #:test-exercises
           #:problems-p
           #:full-build
           #:ci-build)
  (:documentation "xlisp-test

Script for running the tests for exercism exercises of the xlisp
track. Used for integration testing on new and changed exercises.

http://exercism.io"))

(in-package #:xlisp-test)

;;; Exit states

;;;; http://tldp.org/LDP/abs/html/exitcodes.html

(defconstant +exit-tests-did-not-run+ 3
  "Exit status for when tests don't run.")

(defconstant +exit-tests-failed+ 4
  "Exit status for when tests fail.")


;;; Optional messaging

(defconstant +warn+  1 "Verbosity level for warnings only.")
(defconstant +info+  2 "Verbosity level for informational messages.")
(defconstant +debug+ 4 "Verbosity level for debug messages.")

(defparameter *verbosity* nil
  "Verbosity of feedback.")

(defun verbosity-p (level)
  (check-type level integer)
  (not (zerop (logand level *verbosity*))))

(defun notice (level datum &rest arguments)
  (when (verbosity-p level)
    (format *standard-output*
            "~2&~A: ~?~%"
            datum
            (first arguments)
            (rest arguments))))

(defun alert (message &rest arguments)
  (notice +warn+ "ALERT" message (values-list arguments)))

(defun inform (message &rest arguments)
  (notice +info+ "INFO" message (values-list arguments)))

(defun babble (message &rest arguments)
  (notice +debug+ "DEBUG" message (values-list arguments)))


;;; Managing paths and packages

(defparameter *exercises*
  (flet ((slug-name (exercise-config)
           (cdr (assoc :slug exercise-config))))
    (with-open-file (config-json "config.json")
      (map 'list
           #'slug-name
           (cdr (assoc :exercises
                        (cl-json:decode-json config-json))))))
  "List of exercise names.")

(defun load-package (filename)
  "Load file expecting a single package to be loaded. Errors."
  (let ((packages-before (list-all-packages))
        (*print-circle* t)) ; https://github.com/exercism/xlisp/issues/77
    (load filename :verbose (verbosity-p +info+) :print (verbosity-p +info+))
    (let ((loaded (set-difference (list-all-packages) packages-before)))
      (typecase (length loaded)
        ((integer 0 0) (error "No packages loaded."))
        ((integer 2) (error "Loaded packages ~{~S~^, ~}" loaded)))
      (let ((package (first loaded)))
        (babble "Loaded package ~S" package)
        package))))

(defun make-xlisp-test-path (exercise-name filename)
  "Make a pathname object from exercise name and filename"
  (merge-pathnames (make-pathname :directory (list :relative "exercises" exercise-name))
                   (make-pathname :name filename :type "lisp")))


;;; Define collection of problematic test results

(defvar *problems*
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
  (when (lisp-unit:failed-tests results)
    (lisp-unit:print-failures results)
    (record-problem results))
  (when (lisp-unit:error-tests results)
    (lisp-unit:print-errors results)
    (record-problem results)))


;;; Define test runner

(defun test-exercise (exercise-name &optional (verbosity (+ +warn+ +info+)))
  "Run the exercise test named."
  (pushnew :xlisp-test *features*)
  (let ((*verbosity* verbosity)
        (test-example-path
             (make-xlisp-test-path exercise-name "example"))
        (test-exercise-path
         (make-xlisp-test-path exercise-name
                               (format nil "~A-test" exercise-name)))
        (example nil)
        (exercise nil))
    (lisp-unit:signal-results)
    (unwind-protect
         (handler-case
             (progn
               (setf example (load-package test-example-path))
               (babble "Loaded example ~S" example)
               (setf exercise (load-package test-exercise-path))
               (babble "Loaded exercise tests ~S" exercise)
               (inform (format nil "Running tests for ~S" example))
               (lisp-unit:run-tests :all exercise))
           (lisp-unit:test-run-complete (condition)
             (handle-results (lisp-unit:results condition)))
           (error (condition) (record-problem condition)))
      (dolist (package (list example exercise))
        (when package (delete-package package))))))

(defun test-exercises (&optional (verbosity (+ +warn+ +info+)))
  "Run all exercise tests."
  (pushnew :xlisp-test *features*)
  (let ((*verbosity* verbosity))
    (inform (format nil "Verbosity level: ~D" *verbosity*))
    (inform "Running all xlisp tests...")
    (and (problems-p) (delete-all-problems))
    (unless *exercises*
      (alert "No exercises defined.")
      (uiop:quit +exit-tests-did-not-run+))
    (dolist (exercise *exercises* (problems-p))
      (test-exercise exercise *verbosity*))))

(defun full-build ()
  "Execute a full build including all tests."
  (test-exercises))

(defun ci-build ()
  "Execute a full build, and if it fails, exit with an error code."
  (when (full-build) (uiop:quit +exit-tests-failed+)))
