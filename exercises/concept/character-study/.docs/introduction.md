# Introduction

Common Lisp has characters like other programming languages.
Characters are objects which represent an item in a quantity of text (e.g. a string or text stream).

Characters can be converted to and from integers. (But they are *not* integers - they are a distinct type.)

Characters are represented as `#\` followed by its name.
The 'name' for common characters such as 'A' or 'b' or '9' or '!' are simply that: so `#\A`, `#\b`, `#\9` and `#\!`.
Some non-graphical characters such as space or new-line have names such as `#\Space` and `#\Newline`.

The standard only requires an implementation to have 96 characters (upper and lower case Latin alphabetic characters, the digits 0-9, space, newline and punctuation.
However most implementations will offer more than that including implementations which provide all Unicode characters.

## Character codes

Each character has a 'code' which is a non-negative integer which is unique to that character in a specific implementation.
For example:

(Note the mapping of character to integer is dependent upon implementation so your implementation may have the same or different codes as the examples.)

## Comparing characters.

Characters can be compared for equality by `char=` or `char-equal` (the latter being case-insensitive).

Characters can be ordered with functions such as `char<`, `char>`, `char<=`, `char>=` and their case-insensitive versions `char-lessp` and `char-greaterp`.

## Types of characters

Characters can be categorized as different types: graphical, alphabetic, alpha-numeric, digit, upper-case or lower-case. 
A character can be more than one type such as an upper-case alphabetic character.
There are predicates for each of these types: `graphic-char-p`, `alpha-char-p`, `alphanumericp`, `digit-char-p`, `upper-case-p` and `lower-case-p`.
