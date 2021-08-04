# Instructions

Larry is a Lisp Alien that likes to write code to play games. 
Today they want to write a few functions to help them with a game which is a lot like tic-tac-toe.

Like tic-tac-toe this game is played on a board which is a 3x3 grid.

## 1. Starting from scratch

First Larry needs a function to make a blank board `make-empty-board`
All the cells of the board should be `NIL`.

## 2. Starting from an existing board

Next Larry needs a function to make a board from a list of rows. 
For example:

```lisp
(make-board-from-list '((A B C) (D E F) (G H I))) ; => #2A((A B C) (D E F) (G H I))
```

## 3. Winning condition

If there is a case where there are 3 of the same symbol in a row then that player has won.
Larry will need a function `all-the-same-p` which given an array of 3 items will evaluate to `T` if all the items are the same symbol.
(`eq` can be used to determine if two symbols are the same.)

## 4. In a row

Now Larry needs a way to get the elements of a row.
The function `row` will take a board and a row number and should return an array of the elements in that row.

## 5. In a column

Finally Larry needs a way to get the elements of a column.
The function `column` will take a board and a column number and should return an array of the elements in that column.
