(in-package #:cl-user)
(defpackage #:octal
  (:use #:cl)
  (:export #:to-decimal))

(in-package #:octal)

;; This is probably the worst way I can think of to do this...
(defun to-decimal (input)
  (to-dec-helper 0 input 0 (length input)))

(defun to-dec-helper (tot str cur len)
  (let ((idx (- len cur 1)))
    (if (<= idx -1)
        tot
        (let* ((c (elt str idx))
               ;; I know there is a better way to do this... do you?
               (d (and (char<= #\0 c #\7)
                       (digit-char-p c))))
          (if d
              (to-dec-helper (+ tot
                                (* d (expt 8 cur)))
                             str
                             (1+ cur)
                             len)
              0)))))
