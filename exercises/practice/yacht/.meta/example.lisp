(defpackage :yacht
  (:use :cl)
  (:export :score))
(in-package :yacht)

(defun hash-values (ht)
  (loop for v being each hash-value of ht collect v))

(defun frequencies (sequence)
  (let ((occurences (make-hash-table)))
    (reduce (lambda (acc n)
              (incf (gethash n acc 0))
              acc)
            sequence
            :initial-value occurences)))

(defun full-house (occurences)
  (let ((vals (hash-values occurences)))
        (equal '(2 3) (sort vals #'<))))

(defun four-of-a-kind-dice (occurences)
  (let ((pair nil))
    (maphash (lambda (key val)
              (when (>= val 4)
                  (setf pair key)))
             occurences)
    pair))

(defun score (scores category)
  "Returns the score of the dice for the given category."
  (case category
    (:ones (count 1 scores))
    (:twos (* 2 (count 2 scores)))
    (:threes (* 3 (count 3 scores)))
    (:fours (* 4 (count 4 scores)))
    (:fives (* 5 (count 5 scores)))
    (:sixes (* 6 (count 6 scores)))
    (:full-house (if (full-house (frequencies scores))
                                       (reduce '+ scores)
                                       0))
    (:four-of-a-kind (let ((dice (four-of-a-kind-dice (frequencies scores))))
                                            (if dice (* 4 dice) 0)))
    (:little-straight (if (equal '(1 2 3 4 5) (sort scores #'<))
                                            30
                                            0))
    (:big-straight (if (equal '(2 3 4 5 6) (sort scores #'<))
                                         30
                                         0))
    (:choice (reduce '+ scores))
    (:yacht (if (= 1 (hash-table-count (frequencies scores)))
                                  50
                                  0))
    (t 0)))
