# Instructions

Leslie the Lisp Alien needs to do some shopping. It is very important to have a shopping list. One needs to add things to it, and remove things from it.

Of course simple pen and paper will not do for a Lisp Alien. "List" is most of the word "Lisp" even!. There must be some functions written to help keep track of the shopping.

Can you help Leslie keep track of the shopping list?

## 1. Making a new list

First thing is that Leslie needs to create a empty list. A function called `new-list` would be perfect for that.

```lisp
(new-list) ; => ()
```

Oh no... Leslie has a few things in mind already, so they need a function that takes three items (luckily Leslie only creates a list of three items. Nothing more, nothing less!) and creates a new shopping list with those things. Write a function, `list-of-things` which takes three items and retunrs a list of them.

```lisp
(list-of-things 'bread 'milk 'butter) ; => '(bread milk butter)
```

## 2. Add things to the list.

Before going to the store Leslie looks in the pantry to see what they need. Help them by writing the function `add-to-list` which adds an item to the beginning of a list.

```lisp
(add-to-list 'butter '(bread)) ; => '(butter bread)
```

## 3. What's next thing(s) on the list?

When shopping, Leslie wants to know what to look for next. They also like to peek ahead at the list to see the second, third, or even the 23rd item (their lucky number).

- `first-thing` will evaluate to the first thing on the list
- `second-thing` will evaluate to the second thing
- `third-thing` will evaluate to the third thing
- `twenty-third-thing` will evaluate to the twenty-third thing

```lisp
(first-thing '(bread butter milk)) ; => 'bread
(second-thing '(bread butter milk)) ; => 'butter
(third-thing '(bread butter milk)) ; => 'milk
```

## 4. Removing a thing from the list

Leslie wants to find the first item of the list and remove the it from the shelf.
Help them out by writing a function `remove-first-item` which evaluates to a list with everything but the first item on the input list.

```lisp
(remove-first-item '(bread butter milk)) ; => '(butter milk)
```

## 5. Bigger lists out of smaller lists

Leslie realized they accidentally made two shopping lists, not one! Write a function, `list-append` which returns a list that with the elements from the first list followed by the ones from the second list.

```lisp
(list-append '(bread salt) '(butter milk)) ; => '(bread salt butter milk)
```

## 6. How much longer?

Leslie is getting worried that this shopping trip will take a while. Just how many things are on this list? Write a function `just-how-long` to tell them how long their list is.

```lisp
(just-how-long '(bread milk butter salt)) ; => 4
```