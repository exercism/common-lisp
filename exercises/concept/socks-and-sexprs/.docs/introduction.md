# Introduction

## Comments

Common Lisp allows the programmer to write "comments" that are ignored by the computer.
Single-line comments begin with one or more semi-colons (`;`) and, occasionally, you may see the following:

```lisp
(code...) ; => value
```

Where the comment is being used to indicate what value is returned by Common Lisp after running the code on that line.

It is idiomatic to use a single semi-colon for a short comment at the end of a line, two for a longer comment above a section of code, three for long comment describing something such as a function and four for a comment such as a header at the top of a source file.

## Cons

All Common Lisp objects are either "atoms" (single, indivisible values) or "conses" (built by the construct function "cons").
A cons is made up of two parts: the first element and the rest of the elements.
For historical reasons these two parts are called the `car` and the `cdr`.
When these conses are evaluated as code, the first element (`car`) represents the function being called while the rest of the elements
(`cdr`) represent the arguments to that function:

```lisp
(<function> <arg1> <arg2> ... <argN>)
; ^ car ^  |        ^ cdr ^
```

## Expressions

All Common Lisp code is made of S-Expressions (Symbolic Expressions). They are called sexprs for short. Every sexpr is either an atom or a cons. When S-Expressions are evaluated, they automatically return some value which takes the place of the expression. When writing your own functions (using `defun`), the last value within the body of the `defun` is automatically returned:

```lisp
;; Defining a new function
(defun gimme-foo () 'foo)
;; Calling the function as an S-Expression
(gimme-foo) ; => FOO
```

## Symbols

Symbols in Common Lisp are special values that can point to other values or, in the case of _keywords_, themselves.
When symbols are evaluated by Lisp, they are replaced with the values they point to:

```lisp
foo  ; => <whatever-foo-points-to>
:foo ; => :FOO
```

Note that keywords are denoted by a leading colon (`:`).

Quoting – the addition of `'` before an S-expression – tells Lisp to not evaluate that expression.
By quoting `'foo` in our `defun` example, we avoided Lisp attempting to look up (and failing to find) whatever `FOO` was supposed to point to, instead, returning the value `FOO` itself.
If `FOO` has not been defined anywhere in our program:

```lisp
foo  ; => <ERROR! Lisp doesn't know what foo points to!>
'foo ; => FOO
```

For now, you can consider this just as a way to return symbols from a function, but we will revisit quoting and further explore its implications in future concept exercises.
