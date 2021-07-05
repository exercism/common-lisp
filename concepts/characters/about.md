# About

Characters are objects which represent an item in a quantity of text (e.g. a string or text stream).

Characters are represented as `#\` followed by its name (e.g. `#\A`, `#\9`, `#\!`, `#\Space`).

## Comparing

In addition to `char=`, `char<` and `char>`, there are also `char<=` and `char>=` as well as case-insensitive versions such as `char-equal` and `char-greaterp`.

## Ordering 

Characters can be converted to and from integers. (But they are *not* integers - they are a distinct type.) 
The specification leaves the exact ordering of characters to the implementation.
This means one should be careful not to assume `(char> #\a #\A)` or similar assumptions of ordering of characters.
The standard does specify that `(char< #\A #\Z)` and `(char< #\a #\z)` and `(char< #\0 #\9)` must be true.

## Types of characters

Common Lisp has several predicates to determine what "type" of character a specific character is such as `alphanumericp`, `digit-char-p` and `graphic-char-p`.
There are also `upper-case-p` and `lower-case-p` to determine the case of the character.


