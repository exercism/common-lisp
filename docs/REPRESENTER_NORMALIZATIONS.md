# Representer normalizations

The [representer][representer] use `[read][cl-read]` to read the submission and `[write][cl-write]` to write the representation as well as applying some additional normalizations.
In total each submission has the following normalizations applied to it:

## Remove comments

The submission is `[read][cl-read]` in and so all comments are removed.

## Remove documentation strings

Instead of normalizing any names which may be present in the documentation string the string is removed. 
However the representation will note if a documentation string was present or not. 

## Normalize text case

The submission is `[read][cl-read]` in and so all symbols are normalized to uppercase.

## Normalize text formatting

The representation is written with `[write][cl-write]` so any particulars of the submissions formatting (such as indentation, spacing, leaving closing parenthesis on empty lines) are not retained in the representation.

## Normalize symbol names

Symbols such as function, variable and macro names as well packages are mapped to `[gensyms][cl-gensym]` which are used in the representation.

[cl-gensym]: http://www.lispworks.com/documentation/HyperSpec/Body/f_gensym.htm
[cl-read]: http://www.lispworks.com/documentation/HyperSpec/Body/f_rd_rd.htm
[cl-write]: http://www.lispworks.com/documentation/HyperSpec/Body/f_wr_pr.htm
[representer]: https://github.com/exercism/common-lisp-representer
