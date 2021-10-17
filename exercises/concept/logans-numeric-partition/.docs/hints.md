# Hints

## 1. Categorizing a number

* The functions `evenp` or `oddp` can be used to determine if a number is even or odd.
* The function `append` can be used to add an item to the beginning of a list.
* The functions `car` and `cdr` are useful to get the first or second item of a pair.

## 2. Categorizing lots of numbers

* `reduce`'s first parameter is a function which takes two arguments - the current accumulated value and the item to process.
* `reduce` takes an `:initial-value` parameter, the value of which will be the first accumulated value passed to the function.
