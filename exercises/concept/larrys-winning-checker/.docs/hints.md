# Hints

## 1. Starting from scratch

- To create an array you can use `make-array`.
- The dimensions of an array are specified as a list of `make-array`.
- To set all elements to a initial value use the `:inital-element` keyword parameter.

## 2. Starting from an existing board

- To set the initial contents of an array use the `:initial-contents` keyword parameter.

## 3. Winning condition

- `aref` can be used to get value of a cell of an array.
- `eq` can be used to determine if two symbols are the same.
- `and` can be used to combine two `eq` expressions to compare three items.

## 4. In a row

- The arguments of `aref` (for a two dimensional array) are "row" and "column".

## 5. In a column

- The arguments of `aref` (for a two dimensional array) are "row" and "column".
