(defpackage :configlet
  (:use :common-lisp)
  (:shadow :format :run-program)
  (:export :download
           :format
           :generate
           :installed-p
           :upgrade
           :uuid))

(in-package :configlet)

(defun ensure-list (thing)
  (typecase thing (list thing) (t (list thing))))

(defun run-program (prog-and-args &key (output t) (error-output t))
  (uiop/run-program:run-program (ensure-list prog-and-args)
                                :force-shell t
                                :ignore-error-status t
                                :output output
                                :error-output error-output))

(defun configlet-command (command &rest args)
  (append (list "./bin/configlet" command) args))

(defun installed-p ()
  (probe-file "./bin/configlet"))

(defun download ()
  (run-program "./bin/fetch-configlet"))

(defun upgrade (&key (output nil))
  (run-program (configlet-command "upgrade") :output output))

(defun format ()
  (run-program (configlet-command "fmt" ".")
               :output :lines :error-output :lines))

(defun uuid ()
  (first (run-program (configlet-command "uuid") :output :lines)))

(defun generate (exercise spec-path)
  (run-program
   (configlet-command "generate" "."
                      "--only" exercise "--spec-path" spec-path)))
