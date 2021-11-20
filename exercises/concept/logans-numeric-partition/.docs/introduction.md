# Introduction

Reducing is the repeated application of a function to each element of
a sequence and accumulating, in some way, the results. 
The function applied takes two parameters: the current accumulated value and the item to process. 
It must evaluate to the new accumulated value.

In Common Lisp the process is done with the `reduce` function.
In its simplest form it looks like:

`(reduce #'function-to-apply sequence :initial-value value)`

Notice that an initial value is provided - this will be the 'current accumulated value' that is passed into the function when the first element is processed.

Here is an example which adds the numbers of the list together starting with an initial value of 10:

`(reduce #'+ '(1 2 3 4) :initial-value 10) ; => 20`

Note that if the sequence is empty the function is never called and the form evaluates to the initial-value.