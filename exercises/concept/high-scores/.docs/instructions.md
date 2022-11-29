# Instructions

Lamont is a Lisp alien that wants to write their own video game. One task they have asked for your help with is keeping track of a high score list.

## 1. Creating the high score table

Define a function `make-high-score-table` which does not take any arguments are evaluates to a new empty hash table:

```lisp
(make-high-score-table) ; => #<HASH-TABLE :TEST EQL :COUNT 0 {1005A90103}>
```

## 2. Adding a player to the table

To add a player to the table define a function `add-player` which takes two arguments:
- the high score table
- the player's name as a keyword

Set the player's initial score to zero.

```lisp
(add-player hash-table :louis) ; => 0
(add-player hash-table :lilly) ; => 0
```

## 3. Setting a player's score

To set the score for a player define a function `set-score` which takes three arguments:
- the high score table
- the player's name as a keyword
- the player's score as an integer

```lisp
(set-score hash-table :louis 1234) ; => 1234
```

## 4. Getting a score from the table

To get a score for a player from the table define a function `get-score` which takes two arguments:
- the high score table
- the player's name as a keyword

This function should evaluate to the score stored for the player.
If there is no score stored for that player, or that player is not yet in the table then evaluate to `0`.

```lisp
(get-score hash-table :louis)                         ; => 1234
(get-score hash-table :lilly)                         ; => 0
(get-score hash-table :not-a-character-in-this-story) ; => 0
```

## 5. Removing a player from the table

To remove a player from the high score table define a function `remove-player` which takes two arguments:
- the high score table
- the player's name as a keyword

This function should gracefully handle cases where the player was not yet added to the table.
Obviously after a player is removed if one gets their score from the table it will be zero.

```lisp
(set-score hash-table :louis 1234)           ; => 1234
(remove-player hash-table :louis)            ; => T
(get-score hash-table :louis)                ; => 0

(remove-player hash-table :not-in-the-table) ; => NIL
```
