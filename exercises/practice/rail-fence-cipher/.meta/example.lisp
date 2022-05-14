(defpackage :rail-fence-cipher
  (:use :cl)
  (:export :encode
           :decode))

(in-package :rail-fence-cipher)

(defun encode (msg rails)
  (let ((fence (make-fence (length msg) rails)))
    (populate-and-sort msg fence #'post-row)))

(defun decode (msg rails)
  (let ((fence (make-fence (length msg) rails)))
    (sort fence #'< :key #'post-row) ; rearrange the fence into its encoded state
    (populate-and-sort msg fence #'post-column)))

(defstruct post letter row column)

(defun make-fence (seq-length rails)
  "Function make-fence will output a list of structs of type post, which will come
to represent a character and its coordinates in the fence.  Function contains a
loop that goes along the columns, and uses mathematical equations to find the
correct row.  Letters are not filled in here, and are set to nil."
  (loop for i from 0 below seq-length with r = (1- rails)
    if (< (mod i (* 2 r)) r) ; if i mod 2r < r then...
    collect (make-post :letter nil :column i :row (mod i r)) ; row = i mod r, else...
    else
    collect (make-post :letter nil :column i :row (- r (mod i r))))) ; row = r - (i mod r)

(defun populate-and-sort (msg fence sort-key)
 "Function populate-and-sort will populate the letters in each post struct from
the chars in msg string.  It will then sort the posts by either rows or columns
(according to the sort-key) and will recombine the letters into an output string."
  (loop for p in fence for c across msg do (setf (post-letter p) c))
  (sort fence #'< :key sort-key)
  (map 'string #'post-letter fence))
