# Hints

## 1. Starting from scratch

- To create an array you can use `make-array`.
- The dimensions of the array are specified as a list of `make-array`.
- To set all elements to a initial value use the `:inital-element` keyword argument.

## 2. Starting from an existing board

- To set the initial contents of an array use the `:initial-contents` keyword argument.

## 3. Winning condition

- `aref` can be used to get value of a cell of an array.
- `eq` can be used to determine if symbols are the same.

## 4. In a row

- The arguments of `aref` (for a two dimensional array) are "column" and "row"

## 5. In a column

- The arguments of `aref` (for a two dimensional array) are "column" and "row"
