;; Ensures that diamond.lisp and the testing library are always loaded
(eval-when (:compile-toplevel :load-toplevel :execute)
  (load "diamond")
  (quicklisp-client:quickload :fiveam))

;; Defines the testing package with symbols from diamond and FiveAM in scope
;; The `run-tests` function is exported for use by both the user and test-runner
(defpackage :diamond-test
  (:use :cl :fiveam)
  (:export :run-tests))

;; Enter the testing package
(in-package :diamond-test)

;; Define and enter a new FiveAM test-suite
(def-suite* diamond-suite)

(test degenerate-case-with-a-single-a-row
    (let ((letter #\A))
      (is (equal '("A") (diamond:rows letter)))))

(test degenerate-case-with-no-row-containing-3-distinct-groups-of-spaces
    (let ((letter #\B)
         (result '(" A "
                   "B B"
                   " A ")))
      (is (equal result (diamond:rows letter)))))

(test smallest-non-degenerate-case-with-odd-diamond-side-length
    (let ((letter #\C)
          (result '("  A  "
                    " B B "
                    "C   C"
                    " B B "
                    "  A  ")))
      (is (equal result (diamond:rows letter)))))

(test smallest-non-degenerate-case-with-even-diamond-side-length
    (let ((letter #\D)
          (result '("   A   "
                    "  B B  "
                    " C   C "
                    "D     D"
                    " C   C "
                    "  B B  "
                    "   A   ")))
      (is (equal result (diamond:rows letter)))))

(test largest-possible-diamond
    (let ((letter #\Z)
          (result '("                         A                         "
                    "                        B B                        "
                    "                       C   C                       "
                    "                      D     D                      "
                    "                     E       E                     "
                    "                    F         F                    "
                    "                   G           G                   "
                    "                  H             H                  "
                    "                 I               I                 "
                    "                J                 J                "
                    "               K                   K               "
                    "              L                     L              "
                    "             M                       M             "
                    "            N                         N            "
                    "           O                           O           "
                    "          P                             P          "
                    "         Q                               Q         "
                    "        R                                 R        "
                    "       S                                   S       "
                    "      T                                     T      "
                    "     U                                       U     "
                    "    V                                         V    "
                    "   W                                           W   "
                    "  X                                             X  "
                    " Y                                               Y "
                    "Z                                                 Z"
                    " Y                                               Y "
                    "  X                                             X  "
                    "   W                                           W   "
                    "    V                                         V    "
                    "     U                                       U     "
                    "      T                                     T      "
                    "       S                                   S       "
                    "        R                                 R        "
                    "         Q                               Q         "
                    "          P                             P          "
                    "           O                           O           "
                    "            N                         N            "
                    "             M                       M             "
                    "              L                     L              "
                    "               K                   K               "
                    "                J                 J                "
                    "                 I               I                 "
                    "                  H             H                  "
                    "                   G           G                   "
                    "                    F         F                    "
                    "                     E       E                     "
                    "                      D     D                      "
                    "                       C   C                       "
                    "                        B B                        "
                    "                         A                         ")))
      (is (equal result (diamond:rows letter)))))

(defun run-tests (&optional (test-or-suite 'diamond-suite))
  "Provides human readable results of test run. Default to entire suite."
  (run! test-or-suite))
