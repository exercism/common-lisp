;; Ensures that protein-translation.lisp and the testing library are always loaded
(eval-when (:compile-toplevel :load-toplevel :execute)
  (load "protein-translation")
  (quicklisp-client:quickload :fiveam))

;; Defines the testing package with symbols from protein-translation and FiveAM in scope
;; The `run-tests` function is exported for use by both the user and test-runner
(defpackage :protein-translation-test
  (:use :cl :fiveam)
  (:export :run-tests))

;; Enter the testing package
(in-package :protein-translation-test)

;; Define and enter a new FiveAM test-suite
(def-suite* protein-translation-suite)

(test empty-rna-sequence-results-in-no-proteins
    (let ((strand "")
          (result (list)))
      (is (equal result (protein-translation:proteins strand)))))

(test methionine-rna-sequence
    (let ((strand "AUG")
          (result (list "Methionine")))
      (is (equal result (protein-translation:proteins strand)))))

(test phenylalanine-rna-sequence-1
    (let ((strand "UUU")
          (result (list "Phenylalanine")))
      (is (equal result (protein-translation:proteins strand)))))

(test phenylalanine-rna-sequence-2
    (let ((strand "UUC")
          (result (list "Phenylalanine")))
      (is (equal result (protein-translation:proteins strand)))))

(test leucine-rna-sequence-1
    (let ((strand "UUA")
          (result (list "Leucine")))
      (is (equal result (protein-translation:proteins strand)))))

(test leucine-rna-sequence-2
    (let ((strand "UUG")
          (result (list "Leucine")))
      (is (equal result (protein-translation:proteins strand)))))

(test serine-rna-sequence-1
    (let ((strand "UCU")
          (result (list "Serine")))
      (is (equal result (protein-translation:proteins strand)))))

(test serine-rna-sequence-2
    (let ((strand "UCC")
          (result (list "Serine")))
      (is (equal result (protein-translation:proteins strand)))))

(test serine-rna-sequence-3
    (let ((strand "UCA")
          (result (list "Serine")))
      (is (equal result (protein-translation:proteins strand)))))

(test serine-rna-sequence-4
    (let ((strand "UCG")
          (result (list "Serine")))
      (is (equal result (protein-translation:proteins strand)))))

(test tyrosine-rna-sequence-1
    (let ((strand "UAU")
          (result (list "Tyrosine")))
      (is (equal result (protein-translation:proteins strand)))))

(test tyrosine-rna-sequence-2
    (let ((strand "UAC")
          (result (list "Tyrosine")))
      (is (equal result (protein-translation:proteins strand)))))

(test cysteine-rna-sequence-1
    (let ((strand "UGU")
          (result (list "Cysteine")))
      (is (equal result (protein-translation:proteins strand)))))

(test cysteine-rna-sequence-2
    (let ((strand "UGC")
          (result (list "Cysteine")))
      (is (equal result (protein-translation:proteins strand)))))

(test tryptophan-rna-sequence
    (let ((strand "UGG")
          (result (list "Tryptophan")))
      (is (equal result (protein-translation:proteins strand)))))

(test stop-codon-rna-sequence-1
    (let ((strand "UAA")
          (result (list)))
      (is (equal result (protein-translation:proteins strand)))))

(test stop-codon-rna-sequence-2
    (let ((strand "UAG")
          (result (list)))
      (is (equal result (protein-translation:proteins strand)))))

(test stop-codon-rna-sequence-3
    (let ((strand "UGA")
          (result (list)))
      (is (equal result (protein-translation:proteins strand)))))

(test sequence-of-two-protein-codons-translates-into-proteins
    (let ((strand "UUUUUU")
          (result (list "Phenylalanine" "Phenylalanine")))
      (is (equal result (protein-translation:proteins strand)))))

(test sequence-of-two-different-protein-codons-translates-into-proteins
    (let ((strand "UUAUUG")
          (result (list "Leucine" "Leucine")))
      (is (equal result (protein-translation:proteins strand)))))

(test translate-rna-strand-into-correct-protein-list
    (let ((strand "AUGUUUUGG")
          (result (list "Methionine" "Phenylalanine" "Tryptophan")))
      (is (equal result (protein-translation:proteins strand)))))

(test translation-stops-if-stop-codon-at-beginning-of-sequence
    (let ((strand "UAGUGG")
          (result (list)))
      (is (equal result (protein-translation:proteins strand)))))

(test translation-stops-if-stop-codon-at-end-of-two-codon-sequence
    (let ((strand "UGGUAG")
          (result (list "Tryptophan")))
      (is (equal result (protein-translation:proteins strand)))))

(test translation-stops-if-stop-codon-at-end-of-three-codon-sequence
    (let ((strand "AUGUUUUAA")
          (result (list "Methionine" "Phenylalanine")))
      (is (equal result (protein-translation:proteins strand)))))

(test translation-stops-if-stop-codon-in-middle-of-three-codon-sequence
    (let ((strand "UGGUAGUGG")
          (result (list "Tryptophan")))
      (is (equal result (protein-translation:proteins strand)))))

(test translation-stops-if-stop-codon-in-middle-of-six-codon-sequence
    (let ((strand "UGGUGUUAUUAAUGGUUU")
          (result (list "Tryptophan" "Cysteine" "Tyrosine")))
      (is (equal result (protein-translation:proteins strand)))))

(test non-existing-codon-cant-translate
    (let ((strand "AAA"))
      (signals protein-translation:invalid-protein (protein-translation:proteins strand))))

(test unknown-amino-acids-not-part-of-a-codon-cant-translate
    (let ((strand "XYZ"))
      (signals protein-translation:invalid-protein (protein-translation:proteins strand))))

(test incomplete-rna-sequence-cant-translate
    (let ((strand "AUGU"))
      (signals protein-translation:invalid-protein (protein-translation:proteins strand))))

(test incomplete-rna-sequence-can-translate-if-valid-until-a-stop-codon
    (let ((strand "UUCUUCUAAUGGU")
          (result (list "Phenylalanine" "Phenylalanine")))
      (is (equal result (protein-translation:proteins strand)))))

(defun run-tests (&optional (test-or-suite 'protein-translation-suite))
  "Provides human readable results of test run. Default to entire suite."
  (run! test-or-suite))
