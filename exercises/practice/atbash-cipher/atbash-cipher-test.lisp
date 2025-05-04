;; Ensures that atbash-cipher.lisp and the testing library are always loaded
(eval-when (:compile-toplevel :load-toplevel :execute)
  (load "atbash-cipher")
  (quicklisp-client:quickload :fiveam))

;; Defines the testing package with symbols from atbash-cipher and FiveAM in scope
;; The `run-tests` function is exported for use by both the user and test-runner
(defpackage :atbash-cipher-test
  (:use :cl :fiveam)
  (:export :run-tests))

;; Enter the testing package
(in-package :atbash-cipher-test)

;; Define and enter a new FiveAM test-suite
(def-suite* atbash-cipher-suite)

(def-suite* encode :in atbash-cipher-suite)

(test encode-yes (is (equal "bvh" (atbash-cipher:encode "yes"))))

(test encode-no (is (equal "ml" (atbash-cipher:encode "no"))))

(test encode-omg (is (equal "lnt" (atbash-cipher:encode "OMG"))))

(test encode-spaces (is (equal "lnt" (atbash-cipher:encode "O M G"))))

(test encode-mindblowingly
  (is (equal "nrmwy oldrm tob" (atbash-cipher:encode "mindblowingly"))))

(test encode-numbers
 (is
  (equal "gvhgr mt123 gvhgr mt"
         (atbash-cipher:encode "Testing, 1 2 3, testing."))))

(test encode-deep-thought
  (is (equal "gifgs rhurx grlm" (atbash-cipher:encode "Truth is fiction."))))

(test encode-all-the-letters
 (let ((plaintext "The quick brown fox jumps over the lazy dog.")
       (cipher "gsvjf rxpyi ldmul cqfnk hlevi gsvoz abwlt"))
   (is (equal cipher (atbash-cipher:encode plaintext)))))

(def-suite* decode :in atbash-cipher-suite)

(test decode-exercism
  (is (equal "exercism" (atbash-cipher:decode "vcvix rhn"))))

(test decode-a-sentence
  (is (equal "anobstacleisoftenasteppingstone"
             (atbash-cipher:decode "zmlyh gzxov rhlug vmzhg vkkrm thglm v"))))

(test decode-numbers
  (is (equal "testing123testing" (atbash-cipher:decode "gvhgr mt123 gvhgr mt"))))

(test decode-all-the-letters
  (is (equal "thequickbrownfoxjumpsoverthelazydog"
             (atbash-cipher:decode "gsvjf rxpyi ldmul cqfnk hlevi gsvoz abwlt"))))

(test decode-with-too-many-spaces
  (is (equal "exercism"
             (atbash-cipher:decode "vc vix    r hn"))))

(test decode-with-no-spaces
  (is (equal "anobstacleisoftenasteppingstone"
             (atbash-cipher:decode "zmlyhgzxovrhlugvmzhgvkkrmthglmv"))))

(defun run-tests (&optional (test-or-suite 'atbash-cipher-suite))
  "Provides human readable results of test run. Default to entire suite."
  (run! test-or-suite))
