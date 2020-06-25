(in-package #:cl-user)
(defpackage #:luhn
  (:use #:cl)
  (:export #:valid-p))

(in-package #:luhn)

(defun is-valid (input)
  (let ((num (remove #\Space input)))
    (when (and (<= 2 (length num))
               (every #'digit-char-p num))
        (gen-checksum num))))

(defun gen-checksum (num)
  (labels ((rec-num (lst tot elm)
            (if (and lst tot)
                (rec-num (cdr lst)
                         (+ tot
                            (let ((num (digit-char-p (car lst))))
                              (cond
                                ((= 1 (mod elm 2))  num)
                                ((< num 5)          (* 2 num))
                                (t                  (- (* 2 num) 9)))))
                         (1+ elm))
                  (= 0 (mod tot 10)))))
    (rec-num (nreverse
              (coerce num
                      'list))
             0
             1)))
