;; Ensures that rail-fence-cipher.lisp and the testing library are always loaded
(eval-when (:compile-toplevel :load-toplevel :execute)
  (load "rail-fence-cipher")
  (quicklisp-client:quickload :fiveam))

;; Defines the testing package with symbols from rail-fence-cipher and FiveAM in scope
;; The `run-tests` function is exported for use by both the user and test-runner
(defpackage :rail-fence-cipher-test
  (:use :cl :fiveam)
  (:export :run-tests))

;; Enter the testing package
(in-package :rail-fence-cipher-test)

;; Define and enter a new FiveAM test-suite
(def-suite* rail-fence-cipher-suite)

(test encode-with-two-rails
    (let ((msg "XOXOXOXOXOXOXOXOXO")
          (rails 2))
      (is (string= "XXXXXXXXXOOOOOOOOO" (rail-fence-cipher:encode msg rails)))))

(test encode-with-three-rails
    (let ((msg "WEAREDISCOVEREDFLEEATONCE")
          (rails 3))
      (is (string= "WECRLTEERDSOEEFEAOCAIVDEN" (rail-fence-cipher:encode msg rails)))))

(test encode-with-ending-in-the-middle
    (let ((msg "EXERCISES")
          (rails 4))
      (is (string= "ESXIEECSR" (rail-fence-cipher:encode msg rails)))))

(test decode-with-three-rails
    (let ((msg "TEITELHDVLSNHDTISEIIEA")
          (rails 3))
      (is (string= "THEDEVILISINTHEDETAILS" (rail-fence-cipher:decode msg rails)))))

(test decode-with-five-rails
    (let ((msg "EIEXMSMESAORIWSCE")
          (rails 5))
      (is (string= "EXERCISMISAWESOME" (rail-fence-cipher:decode msg rails)))))

(test decode-with-six-rails
    (let ((msg "133714114238148966225439541018335470986172518171757571896261")
          (rails 6)
          (result "112358132134558914423337761098715972584418167651094617711286"))
      (is (string= result (rail-fence-cipher:decode msg rails)))))

(defun run-tests (&optional (test-or-suite 'rail-fence-cipher-suite))
  "Provides human readable results of test run. Default to entire suite."
  (run! test-or-suite))
