(defpackage :word-count
  (:use :common-lisp)
  (:export :count-words))

(in-package :word-count)

(defun split-string (string)
  (labels ((split-string-iter (string result)
             (let ((idx (position #\Space string :from-end t)))
               (if idx
                   (split-string-iter (subseq string 0 idx)
                                      (cons (subseq string (1+ idx)) result))
                   (cons string result)))))
    (split-string-iter string (list))))

(defun remove-empty-strings (string-list)
  (remove "" string-list :test #'string=))

(defun trim-quotes-from-words (string-list)
  (mapcar #'(lambda (string) (string-trim '(#\') string)) string-list))

(defun replace-punctuation-with-space (string)
  (substitute-if #\Space #'(lambda (c) (and (not (alphanumericp c))
                                       (char/= c #\')))
                 string))

(defun count-words (sentence)
  (let ((words (remove-empty-strings
                (trim-quotes-from-words
                 (split-string
                  (replace-punctuation-with-space
                   (string-downcase sentence)))))))
    (mapcar #'(lambda (w) (cons w (count w words :test #'string=)))
            (remove-duplicates words :test #'string=))))
