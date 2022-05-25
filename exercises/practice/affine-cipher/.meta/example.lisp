(defpackage :affine-cipher
  (:use :cl)
  (:export :encode
           :decode))

(in-package :affine-cipher)

(defun group (amount str)
  (let* ((len (length str))
         (cut-at (if (> len amount) amount len)))
    (when (plusp len)
      (cons (subseq str 0 cut-at) (group amount (subseq str cut-at))))))

(defun encode-math (character a b)
  (let ((char-idx (- (char-code character) 97)))
    (code-char (+ 97 (mod (+ (* a char-idx) b) 26)))))

(defun decode-math (character inverse-a b)
  (let ((char-idx (- (char-code character) 97)))
    (code-char (+ 97 (mod (* inverse-a (- char-idx b)) 26)))))

(defun encode (plaintext a b)
  (when (= 1 (gcd a 26))
    (let* ((filtered (string-downcase (remove-if-not #'alphanumericp plaintext)))
           (ciphertext (map 'string (lambda (c) (if (digit-char-p c) c (encode-math c a b))) filtered)))
      (format nil "~{~A~^ ~}" (group 5 ciphertext)))))

(defun decode (ciphertext a b)
  (when (= 1 (gcd a 26))
    (let ((filtered (remove #\space ciphertext))
          (inverse-a (loop for x from 1 to 25 when (= 1 (mod (* x a) 26)) return x)))
      (map 'string (lambda (c) (if (digit-char-p c) c (decode-math c inverse-a b))) filtered))))
