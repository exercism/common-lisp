# Hints

## General 

- You'll need [conditional expressions][concept-conditionals] for these exercises.

## 1. Comparing characters

- Characters can be compared with functions such as `char-greaterp`, `char-lessp` and `char=`.

## 2. Determine the "size" of the character

- Common Lisp has two functions to determine if a character is upper-case or lower-case: `upper-case-p` and `lower-case-p`.
- A character can be neither upper-, nor lower-case.

## 3. Changing the "size" of the character

- Common Lisp has two functions for changing the case of a character: `char-upcase` and `char-downcase`.

## 4. Determine the "type" of a character

- Common Lisp has a predicate function `alpha-char-p` to tell if a character is an alphabetic character.
- Common Lisp has a preidicate function `digit-char-p` to tell if a character is a numeric character.
- You can use `char=` to tell if two characters are equal.
- The space character is written #\Space in Common Lisp.
- The newline character is written #\Newline in Common Lisp.

[concept-conditionals]: /tracks/common-lisp/concepts/conditionals
