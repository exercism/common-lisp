;; TODO
;; - assert-error
;; - exercise comment in test file
;; - exercise version number in test file

(defpackage :generate-tests
  (:use :cl :exercise-data)
  (:export :generate))

(in-package :generate-tests)

(defparameter *exercise-pathname-defaults*
  (make-pathname :directory '(:relative "../exercises")))

(defun exercise-directory-pathname (exercise)
  (merge-pathnames (make-pathname :directory (list :relative exercise))
                   *exercise-pathname-defaults*))

(defparameter *canonical-data-pathname-defaults*
  (make-pathname :directory '(:relative "../../problem-specifications/exercises")
                 :name "canonical-data"
                 :type "json"))

(defun canonical-data-pathname (exercise)
  (merge-pathnames (make-pathname :directory (list :relative exercise))
                   *canonical-data-pathname-defaults*))

(defun write-prologue (stream test-data)
  (let* ((name (exercise-name test-data))
         (test-package (format nil "~a-test" name)))
    (format stream "~
(ql:quickload ~w)
#-xlisp-test (load ~w)

(defpackage #:~a
  (:use #:common-lisp #:lisp-unit))

(in-package #:~a)" "lisp-unit" name test-package test-package))
  (terpri stream))

(defun write-epilogue (stream test-data)
  (declare (ignore test-data))
  (format stream "#-xlisp-test
(let ((*print-errors* t)
      (*print-failures* t))
  (run-tests :all))")
  (terpri stream))

(defun write-test (stream package case)
  (let ((description (exercise-case-name case))
        (function (exercise-case-function-info case))
        (inputs (exercise-case-inputs case))
        (expected (exercise-case-expected case)))

    (format stream "~%(define-test
  ~A
  (assert-equal
    ~S
    (~A:~A~{ ~S~})))"
            (substitute #\- #\space description)
            expected package (string-downcase (car function))
            inputs))

  (terpri stream))

(defun write-tests (stream test-data)
  (let ((cases (exercise-cases test-data))
        (package (exercise-name test-data)))
    (dolist (case cases) (write-test stream package case))))

(defun make-exercise-directory (test-data)
  (ensure-directories-exist
   (exercise-directory-pathname (exercise-name test-data))))

(defun make-test-code (test-data)
  (let* ((exercise (exercise-name test-data))
         (exercise-directory (exercise-directory-pathname exercise))
         (test-file (make-pathname :name (format nil "~A-test" exercise)
                                   :type "lisp"
                                   :defaults exercise-directory)))
    (with-open-file (stream test-file
                            :direction :output
                            :if-does-not-exist :create
                            :if-exists :supersede)
      (write-prologue stream test-data)
      (write-tests stream test-data)
      (write-epilogue stream test-data))))

(defun write-production-code (file test-data)
  (with-open-file (stream file
                          :direction :output
                          :if-exists :supersede
                          :if-does-not-exist :create)
    (let ((exercise (exercise-name test-data)))
      (format stream "(in-package #:cl-user)~%")
      (format stream "(defpackage #:~A
  (:use #:cl)
  (:export~{ #:~A~})~%"
              exercise
              '("functions" "to" "export"))
      (format stream "(in-package #:~A)~%~%" exercise)
      (format stream ";; functions go here~% "))))

(defun make-production-code (test-data)
  (let* ((exercise (exercise-name test-data))
         (exercise-directory (exercise-directory-pathname exercise))
         (production-file (make-pathname :name exercise
                                         :type "lisp"
                                         :defaults exercise-directory)))
    (write-production-code production-file test-data)))

(defun make-example-code (test-data)
  (let* ((exercise (exercise-name test-data))
         (exercise-directory (exercise-directory-pathname exercise))
         (example-file (make-pathname :name "example"
                                         :type "lisp"
                                         :defaults exercise-directory)))
    (write-production-code example-file test-data)))

(defun generate (exercise)
  (let ((test-data (read-exercise-data (canonical-data-pathname exercise))))
    (if test-data
        (progn
          (make-exercise-directory test-data)
          (make-test-code test-data)
          (make-production-code test-data)
          (make-example-code test-data))
        (format t "No data found for exercise: ~A" exercise))))
