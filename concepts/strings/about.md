# About

Since strings are [vectors](/tracks/common-lisp/concepts/vectors) which are [sequences](/tracks/common-lisp/concepts/sequences) (both covered in later concepts) all functions that work on sequences will work on strings - such as `position`, `map`, `remove`, `concatenate` _etc._.

There are also more string specific functions to do things such as compare strings to see which is alphabetically more or less `string<` and `string>`; functions to trim characters from the left, right or both sides of a string (`string-trim`).
Refer to the [Hyperspec Section on strings][hyper-string] for full details.

[hyper-string]: http://www.lispworks.com/documentation/HyperSpec/Body/16_a.htm
