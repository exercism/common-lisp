# Instructions

Lewis, a young Lisp Alien, needs to get some work done on their Human alphabets project and asks if you can help them program some functions they will need.

## 1. Comparing characters

Lewis will need a function to compare two characters, determining if the first is greater-than, less-than or equal-to the second.
Write a function `compare-chars` which will take two characters and evaluate to `:greater-than`, `:less-than`, or `:equal-to` appropriately.
The function should compare in a case-sensitive manner.

## 2. Determine the "size" of the character

Lewis needs to know the if a character is "big" (a uppercase character) or "little" (a lowercase character), or "no-size" if it is neither. 
Write a function `size-of-char` that will evaluate to `:big`, `:little` or `:no-size` depending upon the "size" of the character:

## 3. Changing the "size" of the character

Lewis may need to make a big character small, or a small character big.
Write a function `change-size-of-char` which takes two parameters a character and a desired size (`:big` or `:small`). 
It should evaluate to the corresponding character of the correct size.

## 4. Determine the "type" of a character

Not only will Lewis need to know what the 'size' of the character is but also its 'type'. 
Write a function `type-of-char` that will evaluate to `:alpha` if the character is an alphabetic character, `:numeric` if it is a numeric character, `:space` if it is a space character, `:newline` if it is a newline character and `:unknown` otherwise


