(defpackage :generate-exercise-main
  (:use :cl)
  (:export :main))

(in-package :generate-exercise-main)

(defun parse-pathname (arg)
  (pathname (concatenate 'string arg "/")))

(defun fatal-format (msg &rest args)
  (format t "fatal: ")
  (apply #'format t msg args)
  (terpri t)
  (opts:exit 1))

(opts:define-opts
  (:name :help
   :short #\h
   :long "help"
   :description "show this usage info")
  (:name :spec-dir
   :long "spec-dir"
   :description "provide path to problems-specifications repository"
   :arg-parser #'parse-pathname)
  (:name :exercise-dir
   :long "exercise-dir"
   :description "provide path to exercise directory to create exercise in"
   :arg-parser #'parse-pathname))

(defun get-opts ()
  (handler-case (opts:get-opts)
    (opts:unknown-option (condition)
      (fatal-format "fatal: option ~s is unknown!~%" (opts:option condition)))
    (opts:missing-arg (condition)
      (fatal-format "fatal: option ~s needs an argument!~%"
                    (opts:option condition)))
    (opts:arg-parser-failed (condition)
      (fatal-format "fatal: cannot parse ~s as argument of ~s~%"
                    (opts:raw-arg condition)
                    (opts:option condition)))
    (opts:missing-required-option (con)
      (fatal-format "fatal: ~a~%" con))))

(defun main ()
  (multiple-value-bind (options free-args) (get-opts)
    (when (getf options :help)
      (opts:describe :usage-of "generate-exercise" :args "EXERCISE")
      (opts:exit 0))

    (if (zerop (length free-args))
        (fatal-format "Missing EXERCISE argument"))

    (if (> (length free-args) 1)
        (fatal-format "Too many arguments provided: ~S" free-args))

    (generate-exercise:generate
     (car free-args)
     (getf options :spec-dir generate-exercise:*problem-specifications-pathname*)
     (getf options :exercise-dir generate-exercise:*exercises-pathname*))))
