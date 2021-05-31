# About

Everything in Common Lisp is an expression. An expression is either a single thing (called an atom) or a list of things (delimited with parenthesis: `()`.

## Quoting

All S-Expressions, like symbols, can be quoted:

```lisp
;; This line is evaluated as code
(gimme-foo)  ; => FOO

;; This line is treated as data
'(gimme-foo) ; => (GIMME-FOO)
```

This quoting prevents the evaluation of an S-expression, instead treating it
like data. Here is an excellent [Stack Overflow Answer][so-quoting] discussing
quoting in a bit more detail.

[so-quoting]: https://stackoverflow.com/questions/134887/when-to-use-or-quote-in-lisp
