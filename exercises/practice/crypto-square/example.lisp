(in-package #:cl-user)
(defpackage #:crypto-square
  (:use #:cl)
  (:export #:encipher))
(in-package #:crypto-square)

(defun normalize (text)
  (string-downcase (remove-if-not #'alphanumericp text)))

(defun matrix-transpose (matrix)
  (let* ((dimensions (array-dimensions matrix))
         (new-matrix (make-array (reverse dimensions)))
         (x-limit (first dimensions))
         (y-limit (second dimensions)))
    (do ((x 0 (incf x)))
        ((= x x-limit) new-matrix)
      (do ((y 0 (incf y)))
          ((= y y-limit))
        (setf (aref new-matrix y x) (aref matrix x y))))))

(defun text->matrix (text)
  (let* ((length (length text))
         (c (ceiling (sqrt length)))
         (r (if (zerop c) 0 (ceiling (/ (length text) c))))
         (array (make-array (list r c) :initial-element #\Space)))
    (do ((i 0 (incf i)))
        ((= i (length text)) array)
      (setf (row-major-aref array i) (char text i)))))

(defun matrix->text (matrix)
  (let ((max-row (array-dimension matrix 0))
        (max-col (array-dimension matrix 1)))
   (do ((rows (list))
        (r 0 (incf r)))
       ((= r max-row)
        (coerce (butlast (nreverse rows)) 'string))
     (do ((c 0 (incf c)))
         ((= c max-col))
       (push (aref matrix r c) rows))
     (push #\Space rows))))

(defun encipher (plaintext)
  (matrix->text
   (matrix-transpose
    (text->matrix
     (normalize plaintext)))))
