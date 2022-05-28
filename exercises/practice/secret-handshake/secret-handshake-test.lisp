;; Ensures that secret-handshake.lisp and the testing library are always loaded
(eval-when (:compile-toplevel :load-toplevel :execute)
  (load "secret-handshake")
  (quicklisp-client:quickload :fiveam))

;; Defines the testing package with symbols from secret-handshake and FiveAM in scope
;; The `run-tests` function is exported for use by both the user and test-runner
(defpackage :secret-handshake-test
  (:use :cl :fiveam)
  (:export :run-tests))

;; Enter the testing package
(in-package :secret-handshake-test)

;; Define and enter a new FiveAM test-suite
(def-suite* secret-handshake-suite)

(test wink-for-1
    (let ((number 1))
      (is (equal '("wink") (secret-handshake:commands number)))))

(test double-blink-for-10
    (let ((number 2))
      (is (equal '("double blink") (secret-handshake:commands number)))))

(test close-your-eyes-for-100
    (let ((number 4))
      (is (equal '("close your eyes") (secret-handshake:commands number)))))

(test jump-for-1000
    (let ((number 8))
      (is (equal '("jump") (secret-handshake:commands number)))))

(test combine-two-actions
    (let ((number 3))
      (is (equal '("wink" "double blink") (secret-handshake:commands number)))))

(test reverse-two-actions
    (let ((number 19))
      (is (equal '("double blink" "wink") (secret-handshake:commands number)))))

(test reversing-one-action-gives-the-same-action
    (let ((number 24))
      (is (equal '("jump") (secret-handshake:commands number)))))

(test reversing-no-actions-still-gives-no-actions
    (let ((number 16))
      (is (equal '() (secret-handshake:commands number)))))

(test all-possible-actions
    (let ((number 15)
          (result '("wink" "double blink" "close your eyes" "jump")))
      (is (equal result (secret-handshake:commands number)))))

(test reverse-all-possible-actions
    (let ((number 31)
          (result '("jump" "close your eyes" "double blink" "wink")))
      (is (equal result (secret-handshake:commands number)))))

(test do-nothing-for-zero
    (let ((number 0))
      (is (equal '() (secret-handshake:commands number)))))

(defun run-tests (&optional (test-or-suite 'secret-handshake-suite))
  "Provides human readable results of test run. Default to entire suite."
  (run! test-or-suite))
