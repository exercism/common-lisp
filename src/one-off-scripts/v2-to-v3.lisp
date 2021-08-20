;;;;
;;;; HOW TO USE:
;;;;
;;;; (load "./src/one-off-scripts/v2-to-v3.lisp")
;;;; (convert "./exercises/practice/robot-simulator/")
;;;;

(eval-when (:compile-toplevel :load-toplevel :execute)
  (ql:quickload "yason"))

;;;
;;; proto-abstraction for "exercise"
;;;
(defun exercise-init (pathname)
  (merge-pathnames pathname))

(defun exercise-slug (exercise)
  (first (last (pathname-directory exercise))))

(defun exercise-file-name (exercise relative-path)
  (merge-pathnames relative-path exercise))

(defun exercise-test-file (exercise)
  (exercise-file-name exercise
                      (make-pathname :name (format nil "~A-test"
                                                   (exercise-slug exercise))
                                     :type "lisp")))

(defun exercise-source-file (exercise)
  (exercise-file-name exercise
                      (make-pathname :name (exercise-slug exercise)
                                     :type "lisp")))

(defun exercise-config-file (exercise)
  (exercise-file-name exercise
                      (make-pathname :directory '(:relative ".meta")
                                     :name "config"
                                     :type "json")))

;;;
;;; Transformation of test file
(defun load-test-forms (exercise)
  ;; load source file to define package and symbols, will delete below
  (load (exercise-source-file exercise))
  (uiop:read-file-forms (exercise-test-file exercise)))

(defun transform-quickload (slug form)
  (declare (ignore form))
  `((:comment
     ,(format nil
              "Ensures that ~A.lisp and the testing library are always loaded"
              slug))
    (eval-when (:compile-toplevel :load-toplevel :execute)
      (load ,slug)
      (ql:quickload :fiveam))))

(defun transform-defpackage (slug form)
  (list (list :comment
              (format nil "Defines the testing package with symbols from ~A and FiveAM in scope" slug))
        (list :comment "The `run-tests` function is exported for use by both the user and test-runner")
        (append (substitute-if '(:use :cl :fiveam)
                        #'(lambda (x) (and (listp x) (eq (car x) :use)))
                        form)
                '((:export :run-tests)))))

(defun transform-inpackage (slug form)
  (list (list :comment "Enter the testing package")
        form
        "" ;; blank line
        (list :comment "Define and enter a new FiveAM test-suite")
        (list 'def-suite* (intern (format nil "~:@(~A~)-SUITE" slug)))))

(defun transform-define-test (slug form)
  `(test ,(second form)
         ,@(transform slug (cddr form))))

(defun transform-let (slug form)
  (append '(let)
          (list (second form))
          (transform slug (cddr form))))

(defun transform-assert-equal (slug form)
  (declare (ignore slug))
  `(is (equal ,@(cdr form))))

(defun transform-assert-equalp (slug form)
  (declare (ignore slug))
  `(is (equalp ,@(cdr form))))

(defun transform-assert-true (slug form)
  (declare (ignore slug))
  `(is ,@(cdr form)))

(defun transform-assert-false (slug form)
  (declare (ignore slug))
  `(is (not ,@(cdr form))))

(defun transform-assert-error (slug form)
  (declare (ignore slug))
  `(signals ,@(cdr form)))

(defun run-test-block-p (form)
  "Checks if LET expression is the old v2 'run-test' block by looking at first
variable binding."
  (member (caaadr form) '(*print-errors* *print-failures*)))

(defun transform-run-test-block (slug form)
  (declare (ignore form))
  `(defun run-tests (&optional (test-or-suite
                                ,`(quote ,(intern (format nil "~:@(~A~)-SUITE" slug)))))
     "Provides human readable results of test run. Default to entire suite."
     (run! test-or-suite)))

;;; big messy old dispatcher.
;;; especially messy because of some silly special casing.
(defun transform (slug forms)
  (do ((form (car forms) (car forms))
       (forms (cdr forms) (cdr forms))
       (result (list)))
      ((null form) (nreverse result))

    (cond ((atom form) (push form result))
          ((eq (car form) 'quicklisp-client:quickload)
           (push (transform-quickload slug form) result))
          ((equal form (list 'load slug)) nil)
          ((eq (car form) 'defpackage)
           (push (transform-defpackage slug form) result))
          ((eq (car form) 'in-package)
           (push (transform-inpackage slug form) result))
          ((eq (car form) 'define-test)
           (push (transform-define-test slug form) result))
          ((eq (car form) 'let)
           (push (if (run-test-block-p form)
                     (transform-run-test-block slug form)
                     (transform-let slug form))
                 result))
          ((eq (car form) 'assert-equal)
           (push (transform-assert-equal slug form) result))
          ((eq (car form) 'assert-equalp)
           (push (transform-assert-equalp slug form) result))
          ((eq (car form) 'assert-true)
           (push (transform-assert-true slug form) result))
          ((eq (car form) 'assert-false)
           (push (transform-assert-false slug form) result))
          ((eq (car form) 'assert-error)
           (push (transform-assert-error slug form) result))
          (t (push (transform slug form) result)))))

;;;
;;; Writing
;;;
(defun write-form (expr stream)
  "Write a EXPR to STREAM. EXPR is either FORM or ((:COMMENT STRING)+ FORM)"

  (if (and (listp expr)
           (listp (car expr))
           (eq (caar expr) :comment))

      (dolist (form expr)
        (if (and (listp form) (eq (car form) :comment))
            (write-form (format nil ";; ~A" (cadr form)) stream)
            (write-form form stream)))

      (format stream "~@?~%" (if (stringp expr) "~A" "~S") expr)))

(defun write-forms (forms stream)
  (let ((*print-case* :downcase))

    (write-form (car forms) stream)
    (dolist (form (cdr forms))
      (terpri stream)
      (write-form form stream))))


;;;
;;; Entire Converstion
;;;
(defun convert-exercise (path-to-exercise)
  "Converts a v2 exercise to a v3 exercise.
EXERCISE must be a pathname to the v2 exercise directory (relative is OK).
Behavior undefined if run on a v3 exercise.
Does not evaluate to any useful value."
  (when (member :xlisp-test *features*)
    (format *debug-io* ";; :XLISP-TEST found in *FEATURES* removing!!~&")
    (setq *features* (delete :xlisp-test *features*)))

  (let ((exercise (exercise-init path-to-exercise)))
    ;; transform test file
    (let ((forms (load-test-forms exercise))
          (test-file (exercise-test-file exercise))
          (slug (exercise-slug exercise)))
      (format *debug-io* ";; CONVERT ~A~&" test-file)
      (with-open-file (stream test-file
                       :direction :output
                       :if-exists :supersede)
        (write-forms (transform slug forms) stream)))

    ;; transform config profile
    (let ((config-file (exercise-config-file exercise)))
      (format *debug-io* ";; CONVERT ~A~&" config-file)
      (let ((config (yason:parse config-file)))
        (remhash "v2" config)
        (with-open-file (stream config-file :direction :output :if-exists :supersede)
          (yason:encode config (yason:make-json-output-stream stream))))))
  (values))
