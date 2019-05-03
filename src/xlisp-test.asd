(defsystem "xlisp-test"
  :name "xlisp-test"
  :version "0.0.1"
  :description "Utility to run all exercise test"

  :depends-on ("cl-json")

  :pathname "xlisp-test"
  :components ((:file "xlisp-test")))

(defsystem "xlisp-test/test"
  :description "Runs all exercise tests when loaded."
  :depends-on ("xlisp-test")
  :build-operation test-op
  :perform (test-op (o c)
                    (declare (ignore o c))
                    (uiop:symbol-call :xlisp-test '#:full-build)))
