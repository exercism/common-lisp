# Instructions

Lisp Aliens like to celebrate anniversaries.
To them an important anniversary date is the Gigasecond.
That is: 1,000,000,000 seconds since the event.

## 1. Compute the Gigasecond anniversary date

Write a function `from` which takes 6 parameters: `year`, `month`, `day`, `hour`, `min`, `sec` and computes the date and time of the Gigasecond anniversary.
This function should return the date as a list of the same order and meaning as the parameters of the input.

```
(from 2000 1 1 0 0 0) ; => (2031 9 9 1 46 40)
```
