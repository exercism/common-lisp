# About

## Ordering of characters

The specification leaves the exact ordering of characters to the implementation. 
This means one should be careful not to assume `(char> #\a #\A)` or similar assumptions of ordering of characters.
Also one should be careful not to use an expression such as `(char<= #\a x #\z)` to determine if a character is lower-cased.

The standard does specify that `(char< #\A #\Z)` and `(char< #\a #\z)` and `(char< #\0 #\9)` must be true.
