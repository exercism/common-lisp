# Introduction

In Common Lisp time is represented in four ways, two of which will be touched upon here.

- Universal time is an absolute time, an integer representing the number of seconds since `1900-01-01T00:00:00Z` (that is midnight on January 1st, 1900 in the UTC).
- Decoded time is a tuple of 9 values, that together represent a specific calendar time: seconds, minutes, hour, day-of-month, month, year, day-of-week, DST flag, time zone.
(Discussed in detail below.)

## Universal Time

To get current universal time one uses `get-universal-time` or `get-decoded-time`.
The former returns the current seconds since `1900-01-01T00:00Z` and the latter returns the same data in decoded format.

## Decoded Time

`decode-universal-time` and `encode-universal-time` are the primary functions for working with time.
The former takes a universal time and returns a decoded time value as [multiple-values][concept-multiple-values] and the latter takes the decoded time values as arguments and returns a universal time.

Both take an optional time-zone argument.
See below for the format of the time-zone.

A decoded time is a set of values:

- *seconds*: an integer between 0 and 59
- *minutes*: an integer between 0 and 59
- *hour*: an integer between 0 and 23
- *day-of-month*: an integer between 1 and 31 (upper limit actually depends upon month and year obviously)
- *month*: an integer between 1 and 12
- *year*: an integer indicating the year.
- *day of week*: an integer between 0 and 6. 0 means Monday, 1 means Tuesday etc. ... 6 means Sunday.
- *daylight saving time flag*: true value indicates DST is in effect.
- *timezone*: a number of hours between -24 and 24 signifying the offset from UTC.
The number is a rational number and must be a multiple of `1/3600`

```lisp
(encode-universal-time 1 2 3 4 5 2000 0) ; => 3166398121
(decode-universal-time 3166398121)       ; => 1
                                         ;    2
                                         ;    3
                                         ;    4
                                         ;    5
                                         ;    2000
                                         ;    3 (Thursday)
                                         ;    NIL
                                         ;    0
(decode-universal-time 2208988800) ; => 0
                                   ;    0
                                   ;    0
                                   ;    1
                                   ;    1
                                   ;    1970
                                   ;    3
                                   ;    NIL
                                   ;    0
```

[concept-multiple-values]: /tracks/common-lisp/concepts/multiple-values


