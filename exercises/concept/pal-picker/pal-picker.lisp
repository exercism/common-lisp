(defpackage :pal-picker
  (:use :cl)
  (:export :pal-picker :habitat-fitter :feeding-time
           :pet :play-fetch))

(in-package :pal-picker)

(defun pal-picker (personality))

(defun habitat-fitter (weight))

(defun feeding-time (fullness))

(defun pet (pet))

(defun play-fetch (pet))
