(in-package #:cl-user)
(defpackage #:crypto-square
  (:use #:cl)
  (:export #:encipher))
(in-package #:crypto-square)

(defun normalize (text)
  (string-downcase (remove-if-not #'alpha-char-p text)))

(defun matrix-transpose (matrix)
  (let ((new-matrix (make-array (array-dimensions matrix))))
    (do ((x 0 (incf x)))
        ((= x (array-dimension matrix 0)) new-matrix)
      (do ((y 0 (incf y)))
          ((< x y))
        (setf (aref new-matrix x y) (aref matrix y x)
              (aref new-matrix y x) (aref matrix x y))))))

(defun text->matrix (text)
  (let* ((n (ceiling (sqrt (length text))))
         (array (make-array (list n n) :initial-element #\Space)))
    (do ((i 0 (incf i)))
        ((= i (length text)) array)
      (setf (row-major-aref array i) (char text i)))))

(defun matrix->text (matrix)
  (do ((rows (list))
       (x 0 (incf x)))
      ((= x (array-total-size matrix))
       (coerce (reverse rows) 'string))
    (let ((c (row-major-aref matrix x)))
      (when (and (not (zerop x))
                 (zerop (mod x (array-dimension matrix 0))))
        (push #\Space rows))
      (when (char/= c #\Space)
        (push (row-major-aref matrix x) rows)))))

(defun encipher (plaintext)
  (matrix->text
   (matrix-transpose
    (text->matrix
     (normalize plaintext)))))
