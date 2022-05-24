;; Ensures that pig-latin.lisp and the testing library are always loaded
(eval-when (:compile-toplevel :load-toplevel :execute)
  (load "pig-latin")
  (quicklisp-client:quickload :fiveam))

;; Defines the testing package with symbols from pig-latin and FiveAM in scope
;; The `run-tests` function is exported for use by both the user and test-runner
(defpackage :pig-latin-test
  (:use :cl :fiveam)
  (:export :run-tests))

;; Enter the testing package
(in-package :pig-latin-test)

;; Define and enter a new FiveAM test-suite
(def-suite* pig-latin-suite)

(test word-beginning-with-a
    (let ((phrase "apple"))
      (is (string= "appleay" (pig-latin:translate phrase)))))

(test word-beginning-with-e
    (let ((phrase "ear"))
      (is (string= "earay" (pig-latin:translate phrase)))))

(test word-beginning-with-i
    (let ((phrase "igloo"))
      (is (string= "iglooay" (pig-latin:translate phrase)))))

(test word-beginning-with-o
    (let ((phrase "object"))
      (is (string= "objectay" (pig-latin:translate phrase)))))

(test word-beginning-with-u
    (let ((phrase "under"))
      (is (string= "underay" (pig-latin:translate phrase)))))

(test word-beginning-with-a-vowel-and-followed-by-a-qu
    (let ((phrase "equal"))
      (is (string= "equalay" (pig-latin:translate phrase)))))

(test word-beginning-with-p
    (let ((phrase "pig"))
      (is (string= "igpay" (pig-latin:translate phrase)))))

(test word-beginning-with-k
    (let ((phrase "koala"))
      (is (string= "oalakay" (pig-latin:translate phrase)))))

(test word-beginning-with-x
    (let ((phrase "xenon"))
      (is (string= "enonxay" (pig-latin:translate phrase)))))

(test word-beginning-with-q-without-a-following-u
    (let ((phrase "qat"))
      (is (string= "atqay" (pig-latin:translate phrase)))))

(test word-beginning-with-ch
    (let ((phrase "chair"))
      (is (string= "airchay" (pig-latin:translate phrase)))))

(test word-beginning-with-qu
    (let ((phrase "queen"))
      (is (string= "eenquay" (pig-latin:translate phrase)))))

(test word-beginning-with-qu-and-a-preceding-consonant
    (let ((phrase "square"))
      (is (string= "aresquay" (pig-latin:translate phrase)))))

(test word-beginning-with-th
    (let ((phrase "therapy"))
      (is (string= "erapythay" (pig-latin:translate phrase)))))

(test word-beginning-with-thr
    (let ((phrase "thrush"))
      (is (string= "ushthray" (pig-latin:translate phrase)))))

(test word-beginning-with-sch
    (let ((phrase "school"))
      (is (string= "oolschay" (pig-latin:translate phrase)))))

(test word-beginning-with-yt
    (let ((phrase "yttria"))
      (is (string= "yttriaay" (pig-latin:translate phrase)))))

(test word-beginning-with-xr
    (let ((phrase "xray"))
      (is (string= "xrayay" (pig-latin:translate phrase)))))

(test y-is-treated-like-a-consonant-at-the-beginning-of-a-word
    (let ((phrase "yellow"))
      (is (string= "ellowyay" (pig-latin:translate phrase)))))

(test y-is-treated-like-a-vowel-at-the-end-of-a-consonant-cluster
    (let ((phrase "rhythm"))
      (is (string= "ythmrhay" (pig-latin:translate phrase)))))

(test y-as-second-letter-in-two-letter-word
    (let ((phrase "my"))
      (is (string= "ymay" (pig-latin:translate phrase)))))

(test a-whole-phrase
    (let ((phrase "quick fast run"))
      (is (string= "ickquay astfay unray" (pig-latin:translate phrase)))))

(defun run-tests (&optional (test-or-suite 'pig-latin-suite))
  "Provides human readable results of test run. Default to entire suite."
  (run! test-or-suite))
