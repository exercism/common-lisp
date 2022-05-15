(defpackage :pig-latin
  (:use :cl)
  (:export :translate))

(in-package :pig-latin)

(defparameter +vowels+ '("a" "e" "i" "o" "u" "xr" "yt"))

(defun translate (phrase)
  (loop for word in (split-string phrase)
    collect (translate-word word) into output
    finally (return (format nil "~{~A~^ ~}" output))))

(defun translate-word (word)
  (let ((index (take-consonants word)))
    (format nil "~A~Aay" (subseq word index) (subseq word 0 index))))

(defun take-consonants (word &optional (index 0))
  (let ((stopp (lambda (w i) (or (starts-with-p w +vowels+)
                                 (and (char= #\y (char w 0)) (= 1 i))))))
    (cond
      ((funcall stopp word index) index)
      ((starts-with-p word '("qu")) (take-consonants (subseq word 2) (+ 2 index)))
      (t (take-consonants (subseq word 1) (1+ index))))))

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
