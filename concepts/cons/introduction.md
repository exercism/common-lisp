# Introduction

All Common Lisp objects are either "atoms" (single, indivisible values) or "conses" (built by the construct function "cons").
A cons is made up of two parts: the first element and the rest of the elements.
For historical reasons these two parts are called the `car` and the `cdr`.
When these conses are evaluated as code, the first element (`car`) represents the function being called while the rest of the elements
(`cdr`) represent the arguments to that function:

```lisp
(<function> <arg1> <arg2> ... <argN>)
; ^ car ^  |        ^ cdr ^
```
