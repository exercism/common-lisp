# Hints

## General

- If you're not sure where to start, try counting the number of "branches" that
  are needed by any given conditional
- Check out [this
  tutorial](https://riptutorial.com/common-lisp/example/11082/conditional-constructs)
  on most Common Lisp conditionals (excluding `case`)
- [This page](https://www.cs.cmu.edu/Groups/AI/html/cltl/clm/node84.html)
  provides even more detail and also covers `case`

## 1. Picking a Pal

- This task requires a multi-branch conditional
- Remember that keywords are just special symbols always equal to themselves

## 2. In Their Natural Habitat

- This task requires a multi-branch conditional
- It may be worth looking into the order in which branches of [this
  expression](http://www.lispworks.com/documentation/HyperSpec/Body/m_cond.htm) are evaluated.

## 3. And Now, We Feast

- This task requires a two-branch conditional

## 4. A Code of Conduct

- This task requires single-branch conditionals
- One action is unfitting when `pet` is a particular pet
- The other action is unfitting unless `pet` is a particular pet
- For comparing two strings for equality, the `equal` or `string=` functions can be used (you'll see more about this in the [Equality] and [Strings] concepts)

[Equality]: /tracks/common-lisp/concepts/equality
[Strings]: /tracks/common-lisp/concepts/strings
