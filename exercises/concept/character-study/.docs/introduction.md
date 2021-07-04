# Introduction

Common Lisp has characters like other programming languages.
Characters are objects which represent an item in a quantity of text (e.g. a string or text stream).

Characters can be converted to and from integers. (But they are *not* integers - they are a distinct type.)

Characters are represented as `#\` followed by its name.
The 'name' for common characters such as 'A' or 'b' or '9' or '!' are simply that: so `#\A`, `#\b`, `#\9` and `#\!`.
Some non-graphical characters such as space or new-line have names such as `#\Space` and `#\Newline`.

The standard only requires an implementation to have 96 characters (upper and lower case Latin alphabetic characters (`A-Za-z`), the digits (`0-9`), space (`#\Space`), newline (#\Newline) and punctuation (e.g. ``!$"'(),_-./:;?+<=>#%&*@[\]{|}`^~``)
However most implementations will offer more than that, including implementations which provide all Unicode characters.

## Comparing characters.

Characters can be compared for equality by `char=` or `char-equal` (the latter being case-insensitive).

Characters can be ordered with functions such as `char<`, `char>`, `char<=`, `char>=` and their case-insensitive versions `char-lessp` and `char-greaterp`.

## Types of characters

Characters can be categorized as different types: graphical, alphabetic, alpha-numeric, digit, upper-case or lower-case. 
A character can be more than one type such as an upper-case alphabetic character.
There are predicates for each of these types: `graphic-char-p`, `alpha-char-p`, `alphanumericp`, `digit-char-p`, `upper-case-p` and `lower-case-p`.

## Converting character case

Some characters can be upper or lower case and can be converted between them with `char-upcase` and `char-downcase`.
If either is called with a character that is not of the correct case (such as calling)
