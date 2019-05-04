(load "~/.quicklisp/setup.lisp")
(asdf:initialize-source-registry (uiop:getcwd))
(asdf:make
 (format nil "~A/executable" (first (uiop:command-line-arguments))))
