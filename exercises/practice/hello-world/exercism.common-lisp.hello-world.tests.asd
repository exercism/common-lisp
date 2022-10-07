(asdf:defsystem "exercism.common-lisp.hello-world.tests"
  :description  "Hello World Tests"
  :long-description "This system tests the hello world system
as a common-lisp exercism."
  :author     "Helmholtz <add@email.here>"
  :maintainer "Helmholtz <add@email.here>"
  :licence     "AGPL3"
  :version     "1.0.0"
  #+asdf-unicode :encoding #+asdf-unicode :utf-8
  :depends-on ("exercism.common-lisp.hello-world"
               "fiveam")
  :components ((:file "hello-world-test")))

