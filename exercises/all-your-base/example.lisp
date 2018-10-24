(in-package #:cl-user)
(defpackage #:all-your-base
  (:use #:common-lisp)
  (:export #:rebase))

(in-package #:all-your-base)

(defun rebase (list-digits in-base out-base)
  (when (and (< 1 in-base)
             (< 1 out-base)
             (every (lambda (x)
                      (< -1 x in-base))
                    list-digits))
    (if (null list-digits)
        '(0)
        (num->list (list->num list-digits in-base)
                   out-base))))

(defun list->num (lst base)
  (reduce
    (lambda (sum c)
      (+ (* sum base) c))
    lst))

(defun num->list (num base)
  (labels ((listerator (lst rem mult)
            (if (> rem 0)
                (let* ((m (* mult base))
                       (v (mod rem m))
                       (d (/ v mult)))
                  (listerator
                    (cons d lst)
                    (- rem v)
                    m))
                lst)))
    (or (listerator nil num 1)
        '(0))))
