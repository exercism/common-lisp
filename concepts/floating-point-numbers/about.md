# About

Floating-Point Numbers are fractional or whole numbers including a decimal point (like `3.14`, `-1.7`, `99.99`, `2048.0`)

The float type in Common Lisp is subdivided into several subtypes, each with its own characteristics and precision: short-float, single-float, double-float, and long-float.

The short-float subtype typically occupies the least amount of memory and provides the lowest precision among the four subtypes. It is suitable for situations where memory usage is a concern, but less precision is acceptable.

The single-float subtype offers a balance between memory usage and precision. It is commonly used for general-purpose floating-point calculations.

The double-float subtype provides higher precision compared to single-float and is suitable for applications requiring more accurate calculations, such as scientific computations and numerical simulations.

The long-float subtype offers the highest precision among the four subtypes, but it may require more memory compared to the others. It is typically used for specialized applications that demand extremely accurate calculations.

These subtypes allow Common Lisp programmers to choose the appropriate level of precision and memory usage based on the requirements of their specific applications.

In general, if you are working with only whole numbers, you should prefer integers as they don't suffer from the same loss of precision as floating-point numbers do over many calculations.

## Reference

```lisp
;; Rounding to the Nearest Whole Number
(round 3.14)  ; => 3
(round -3.14) ; => -3
(round 2.72)  ; => 3
(round -2.72) ; => -3

;; Rounding Towards Zero
(truncate 3.14)  ; => 3
(truncate -3.14) ; => -3
(truncate 2.72)  ; => 2
(truncate -2.72) ; => -2

;; Rounding Towards Negative Infinity
(floor 3.14)  ; => 3
(floor -3.14) ; => -4
(floor 2.72)  ; => 2
(floor -2.72) ; => -3

;; Rounding Towards Positive Infinity
(ceiling 3.14)  ; => 4
(ceiling -3.14) ; => -3
(ceiling 2.72)  ; => 3
(ceiling -2.72) ; => -2
```
