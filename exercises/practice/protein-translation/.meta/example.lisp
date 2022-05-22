(defpackage :protein-translation
  (:use :cl)
  (:export :proteins
           :invalid-protein))

(in-package :protein-translation)

(define-condition invalid-protein (error) ())

(defun translate (protein)
  (case (intern protein :keyword)
    (:AUG "Methionine")
    ((:UUU :UUC) "Phenylalanine")
    ((:UUA :UUG) "Leucine")
    ((:UCU :UCC :UCA :UCG) "Serine")
    ((:UAU :UAC) "Tyrosine")
    ((:UGU :UGC) "Cysteine")
    (:UGG "Tryptophan")
    ((:UAA :UAG :UGA) nil)
    (otherwise (error 'invalid-protein))))

(defun proteins (strand)
  (let* ((len (length strand))
         (cut-at (if (>= len 3) 3 len)))
    (when (and (plusp len)
               (setf codon (translate (subseq strand 0 cut-at))))
      (cons codon (proteins (subseq strand 3))))))
