(defsystem "test-exercises"
  :description "Test all exercises"
  :version "0.0.0"
  :author "Mark Simpson"
  :mailto "verdammelt@gmail.com"

  :depends-on ()

  :pathname "test-exercises"
  :serial t
  :components ((:file "packages")
               (:file "main"))

  :perform (test-op (o c)
                    (declare (ignore o c))
                    (uiop:symbol-call :test-exercises '#:run-all-tests)))
