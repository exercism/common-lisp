# Representations

The [representer][representer] uses [`read`][cl-read] to read the submission and [`write`][cl-write] to write the representation, as well as applying some additional normalizations.
Each submission has the following normalizations applied to it:

- [All comments are removed][remove-comments]
- [Documentation strings are removed][remove-doc-strings]
- [Text case is normalized][normalize-case]
- [Text formatting is normalized][normalize-formatting]
- [Symbol names are normalized][normalize-names]

[cl-read]: http://www.lispworks.com/documentation/HyperSpec/Body/f_rd_rd.htm
[cl-write]: http://www.lispworks.com/documentation/HyperSpec/Body/f_wr_pr.htm
[normalize-case]: https://exercism.org/docs/tracks/common-lisp/representer-normalizations#h-normalize-text-case
[normalize-formatting]: https://exercism.org/docs/tracks/common-lisp/representer-normalizations#h-normalize-text-formatting
[normalize-names]: https://exercism.org/docs/tracks/common-lisp/representer-normalizations#h-normalize-symbol-names
[remove-comments]: https://exercism.org/docs/tracks/common-lisp/representer-normalizations#h-remove-comments
[remove-doc-strings]: https://exercism.org/docs/tracks/common-lisp/representer-normalizations#h-remove-documentation-strings
[representer]: https://github.com/exercism/common-lisp-representer
