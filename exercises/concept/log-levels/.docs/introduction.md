# Introduction

In Common Lisp strings are vectors of characters (vectors and characters are described in other concept exercises). They are written as characters surrounded by double quotes (_e.g_ "Hello World!").

Strings can be split into sub-strings with the `subseq` function which takes the string a start index and optionally an end index. The indexing is zero-based.

```lisp
(subseq "Hello World" 1 5) ; => "ello"
(subseq "skip to the end" 5) ; => "to the end"
```

Strings can be compared for equality with `string=`. If case of the characters should be ignored then `string-equal` can be used.

```lisp
(string= "macaroni" "macaroni") ; => T
(string= "macaroni" "MACARONI") ; => nil
(string-equal "macaroni" "MACARONI") ; => T
```

Operations like upper-casing, lower-casing and capitalization of strings can be done with `string-upcase` `string-downcase` and `string-capitalize`.

```lisp
(string-upcase "not too loud") ; => "NOT TOO LOUD"
(string-downcase "YELL IT FROM THE ROOFTOPS") ; => "yell it from the rooftops"
(string-capitalize "practical COMMON LiSP") ; => "Practical Common Lisp"
```

