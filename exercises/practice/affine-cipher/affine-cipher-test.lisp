;; Ensures that affine-cipher.lisp and the testing library are always loaded
(eval-when (:compile-toplevel :load-toplevel :execute)
  (load "affine-cipher")
  (quicklisp-client:quickload :fiveam))

;; Defines the testing package with symbols from affine-cipher and FiveAM in scope
;; The `run-tests` function is exported for use by both the user and test-runner
(defpackage :affine-cipher-test
  (:use :cl :fiveam)
  (:export :run-tests))

;; Enter the testing package
(in-package :affine-cipher-test)

;; Define and enter a new FiveAM test-suite
(def-suite* affine-cipher-suite)

(test encode-yes
    (let ((plaintext "yes")
          (a 5)
          (b 7))
      (is (string= "xbt" (affine-cipher:encode plaintext a b)))))

(test encode-no
    (let ((plaintext "no")
          (a 15)
          (b 18))
      (is (string= "fu" (affine-cipher:encode plaintext a b)))))

(test encode-omg
    (let ((plaintext "OMG")
          (a 21)
          (b 3))
      (is (string= "lvz" (affine-cipher:encode plaintext a b)))))

(test encode-o-m-g
    (let ((plaintext "O M G")
          (a 25)
          (b 47))
      (is (string= "hjp" (affine-cipher:encode plaintext a b)))))

(test encode-mindblowingly
    (let ((plaintext "mindblowingly")
          (a 11)
          (b 15))
      (is (string= "rzcwa gnxzc dgt" (affine-cipher:encode plaintext a b)))))

(test encode-numbers
    (let ((plaintext "Testing,1 2 3, testing.")
          (a 3)
          (b 4))
      (is (string= "jqgjc rw123 jqgjc rw" (affine-cipher:encode plaintext a b)))))

(test encode-deep-thought
    (let ((plaintext "Truth is fiction.")
          (a 5)
          (b 17))
      (is (string= "iynia fdqfb ifje" (affine-cipher:encode plaintext a b)))))

(test encode-all-the-letters
    (let ((plaintext "The quick brown fox jumps over the lazy dog.")
          (a 17)
          (b 33)
          (result "swxtj npvyk lruol iejdc blaxk swxmh qzglf"))
      (is (string= result (affine-cipher:encode plaintext a b)))))

(test encode-with-a-not-coprime-to-m
    (let ((plaintext "This is a test.")
          (a 6)
          (b 17))
      (is (equal NIL (affine-cipher:encode plaintext a b)))))

(test decode-exercism
    (let ((ciphertext "tytgn fjr")
          (a 3)
          (b 7))
      (is (string= "exercism" (affine-cipher:decode ciphertext a b)))))

(test decode-a-sentence
    (let ((ciphertext "qdwju nqcro muwhn odqun oppmd aunwd o")
          (a 19)
          (b 16))
      (is (string= "anobstacleisoftenasteppingstone" (affine-cipher:decode ciphertext a b)))))

(test decode-numbers
    (let ((ciphertext "odpoz ub123 odpoz ub")
          (a 25)
          (b 7))
      (is (string= "testing123testing" (affine-cipher:decode ciphertext a b)))))

(test decode-all-the-letters
    (let ((ciphertext "swxtj npvyk lruol iejdc blaxk swxmh qzglf")
          (a 17)
          (b 33)
          (result "thequickbrownfoxjumpsoverthelazydog"))
      (is (string= result (affine-cipher:decode ciphertext a b)))))

(test decode-with-no-spaces-in-input
    (let ((ciphertext "swxtjnpvyklruoliejdcblaxkswxmhqzglf")
          (a 17)
          (b 33)
          (result "thequickbrownfoxjumpsoverthelazydog"))
      (is (string= result (affine-cipher:decode ciphertext a b)))))

(test decode-with-too-many-spaces
    (let ((ciphertext "vszzm    cly   yd cg    qdp")
          (a 15)
          (b 16))
      (is (string= "jollygreengiant" (affine-cipher:decode ciphertext a b)))))

(test decode-with-a-not-coprime-to-m
    (let ((ciphertext "Test")
          (a 13)
          (b 5))
      (is (equal NIL (affine-cipher:decode ciphertext a b)))))

(defun run-tests (&optional (test-or-suite 'affine-cipher-suite))
  "Provides human readable results of test run. Default to entire suite."
  (run! test-or-suite))
