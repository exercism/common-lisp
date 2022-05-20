(defpackage :pig-latin
  (:use :cl)
  (:export :translate))

(in-package :pig-latin)

(defparameter +vowels+ '("a" "e" "i" "o" "u" "xr" "yt"))

(defun split-string (str)
  (unless (zerop (length str))
    (let* ((split-at (position #\space str))
           (word (subseq str 0 split-at))
           (rest-str (string-left-trim " " (subseq str (length word)))))
      (cons word (split-string rest-str)))))

(defun starts-with-p (word search-list)
  (when search-list
    (case (search (car search-list) word)
      (0 T)
      (otherwise (starts-with-p word (cdr search-list))))))

(defun stop-p (word index)
  (or (starts-with-p word +vowels+) (and (char= #\y (char word 0)) (= 1 index))))

(defun take-consonants (word &optional (index 0))
  (cond
    ((stop-p word index) index)
    ((starts-with-p word '("qu")) (take-consonants (subseq word 2) (+ 2 index)))
    (t (take-consonants (subseq word 1) (1+ index)))))

(defun translate-word (word)
  (let ((index (take-consonants word)))
    (format nil "~A~Aay" (subseq word index) (subseq word 0 index))))

(defun translate (phrase)
  (loop for word in (split-string phrase)
    collect (translate-word word) into output
    finally (return (format nil "~{~A~^ ~}" output))))
