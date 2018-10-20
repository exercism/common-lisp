(in-package #:cl-user)
(defpackage #:luhn
  (:use #:cl)
  (:export #:is-valid))

(in-package #:luhn)

(defun is-valid (input)
  (let ((num (remove #\Space input)))
    (if (or (< (length num) 2)
            (not (reduce (lambda (t/f char)
                          (and t/f
                              (char<= #\0 char #\9)))
                        num
                        :initial-value t)))
        nil
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
              (map 'list
                   (lambda (x) x)
                   num))
             0
             1)))
