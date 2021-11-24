# Instructions

Like just about everyone with a job Layla the Lisp Alien sometimes needs to make reports to let others know information. They  ask if you could help them format data she has for these reports.

## 1. Formatting quarterly values

The first thing Layla needs is a function: `format-quarter-value` that takes two parameters: the calendar quarter and the value and formats it for a report. It should evaluate to a string.

```lisp
(format-quarter-value "last" 3.14) ; => "The value last quarter: 3.14"
(format-quarter-value "this" 0) ; => "The value this quarter: 0"
```

## 2. The Two-Quarter report

Layla thanks you for the `format-quarter-value` function and says it will be very useful in the *next* function that is needed.

The next report needs to show the quarter and value from 2 quarters printed on two lines. 

Also the output needs to go to the stream provided as the first argument.

For example: `(format-two-quarters t "last" 3.14 "this" 0)` will produce the following on standard output:

```

The value last quarter: 3.14
The value this quarter: 0

```

Note the blank lines around it.

## 3. Human vs. Lisp Alien readable

Layla forgot to tell you that Lisp Aliens like to see values in a way that is readable as Lisp data. So they need a new function that could be read as lisp data (again to the specified stream):

```lisp
(format-two-quarters-for-reading nil "last" 3.14 "this" 0) ; =>

"(\"The value last quarter: 3.14\" \"The value this quarter: 0\")"
```

