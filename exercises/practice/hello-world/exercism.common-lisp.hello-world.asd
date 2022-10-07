(asdf:defsystem "exercism.common-lisp.hello-world"
  :description  "Hello World"
  :long-description "This system defines the hello world system
as a common-lisp exercism."
  :author     "Helmholtz <add@email.here>"
  :maintainer "Helmholtz <add@email.here>"
  :licence     "AGPL3"
  :version     "1.0.0"
  #+asdf-unicode :encoding #+asdf-unicode :utf-8
  :depends-on ()
  :components ((:file "hello-world")))


