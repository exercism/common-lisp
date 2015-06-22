(defpackage #:xlisp-test
  (:use #:cl #:lisp-unit)
  (:export #:test-exercise
           #:test-exercises
           #:problems-p)
  (:documentation "xlisp-test

Script for running the tests for exercism exercises of the xlisp
track. Used for integration testing on new and changed exercises.

See .travis.yml for how it's run.

http://exercism.io"))

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
    (unless (find #\~ (first arguments))
      (push "~A" arguments))
    (apply #'format t "~&~A: ~@?~%" datum arguments)))

(defun alert (message &rest arguments)
  (notice 1 "ALERT" message (values-list arguments)))

(defun inform (message &rest arguments)
  (notice 2 "INFO" message (values-list arguments)))

(defun babble (message &rest arguments)
  (notice 4 "DEBUG" message (values-list arguments)))


;;; Managing paths and packages

(defparameter *exercises*
  (with-open-file (config-json "config.json")
    (rest (assoc :problems
                 (cl-json:decode-json config-json))))
  "List of exercise names.")

(defun load-package (filename)
  "Load file expecting a single package to be loaded. Errors."
  (let ((packages-before (list-all-packages)))
    (load filename :verbose (verbosity-p 2) :print (verbosity-p 2))
    (let ((loaded (set-difference (list-all-packages) packages-before)))
      (typecase (length loaded)
        ((integer 0 0) (error "No packages loaded."))
        ((integer 2) (error "Loaded packages ~{~S~^, ~}" loaded)))
      (let ((package (first loaded)))
        (babble "Loaded package ~S" package)
        package))))

(defun make-xlisp-test-path (exercise-name filename)
  "Make a pathname object from exercise name and filename"
  (merge-pathnames (make-pathname :directory (list :relative exercise-name))
                   (make-pathname :name filename :type "lisp")))


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

(defun test-exercise (exercise-name)
  "Run the exercise test named."
  (let ((test-example-path
         (make-xlisp-test-path exercise-name "example"))
        (test-exercise-path
         (make-xlisp-test-path exercise-name
                               (format nil "~A-test" exercise-name)))
        (example nil)
        (exercise nil))
    (unwind-protect
         (progn
           (setf example (load-package test-example-path))
           (babble "Loaded example ~S" example)
           (setf exercise (load-package test-exercise-path))
           (babble "Loaded exercise tests ~S" exercise)
           (handler-bind ((test-run-complete
                           (lambda (condition)
                             (handle-results (results condition)))))
             (signal-results)
             (inform (format nil "Running tests for ~S" example))
             (run-tests :all exercise)))
      (dolist (package (list example exercise))
        (delete-package package)))))

(defun test-exercises (&optional (verbosity 2))
  "Run all exercise tests."
  (pushnew :xlisp-test *features*)
  (setf *verbosity* verbosity)
  (inform (format nil "Verbosity level: ~D" *verbosity*))
  (inform "Running all xlisp tests...")
  (and (problems-p) (delete-all-problems))
  (dolist (exercise *exercises* (problems-p))
    (test-exercise exercise)))