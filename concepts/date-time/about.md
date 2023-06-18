# About

In Common Lisp time is represented in three ways

- Universal time is an absolute time, an integer representing the number of seconds since `1900-01-01T00:00:00Z` (that is midnight on January 1st, 1900 in the UTC).
- Decoded time is a tuple of 9 values, that together represent a specific calendar time: seconds, minutes, hour, date, month, year, day-of-week, DST flag, time zone.
(Discussed in detail below.)
- Internal time is an positive integer in implementation defined 'internal time units' which can be used for measurements of run time.

## Universal Time

To get current universal time one uses `get-universal-time` or `get-decoded-time`.
The former returns the current seconds since `1900-01-01T00:00Z` and the later returns the same data in decoded format.

Note that since this number is a positive integer it is impossible to encode dates from before 1900.

## Decoded Time

`decode-universal-time` and `encode-universal-time` are the primary functions for working with time.
The former takes a universal time and returns a decoded time value as [multiple-values][concept-multiple-values] and the later takes the decoded time values as arguments and returns a universal time.

Both take an optional time-zone argument.
See below for the format of the time-zone.

A decoded time is a set of values:

- *seconds*: an integer between 0 and 59
- *minutes*: an integer between 0 and 59
- *hour*: an integer between 0 and 23
- *date*: an integer between 1 and 31 (upper limit actually depends upon month and year obviously)
- *month*: an integer between 1 and 12
- *year*: an integer indicating the year.
- *day of week*: an integer between 0 and 6. 0 means Monday, 1 means Tuesday etc. ... 6 means Sunday.
- *daylight saving time flag*: true value indicates DST is in effect.
- *timezone*: a number of hours between -24 and 24 signifying the offset from UTC.
The number is a rational number and must be a multiple of `1/3600`

```lisp
(encode-universal-time 1 2 3 4 5 2000 0) ; => 3166398121
(decode-universal-time 3166398121 0)     ; => 1
                                         ;    2
                                         ;    3
                                         ;    4
                                         ;    5
                                         ;    2000
                                         ;    3 (Thursday)
                                         ;    NIL
                                         ;    0
(decode-universal-time 2208988800 0)     ; => 0
                                         ;    0
                                         ;    0
                                         ;    1
                                         ;    1
                                         ;    1970
                                         ;    3
                                         ;    NIL
                                         ;    0
```

Note that there is some interesting behavior when the time-zone parameter is not provided.
Review the documentation for [`decode-universal-time`][hyperspec-decode-universal-time] and [`encode-universal-time`][hyperspec-encode-universal-time] for details.

## Internal Time

An internal time is a positive integer number of 'internal time units'. A difference between two of these can be used to measure time during run-time.

- `get-internal-real-time` returns the current "real" or "clock" time.
- `get-internal-run-time` is very implementation dependent and may or may not include time spent paging or garbage collection for instance.

The variable `internal-time-units-per-second` contains a value which is the number of 'internal time units' per second for the current running Lisp environment.

[hyperspec-decode-universal-time]: http://www.lispworks.com/documentation/HyperSpec/Body/f_dec_un.htm#decode-universal-time
[hyperspec-encode-universal-time]: http://www.lispworks.com/documentation/HyperSpec/Body/f_encode.htm#encode-universal-time
[concept-multiple-values]: /tracks/common-lisp/concepts/multiple-values

