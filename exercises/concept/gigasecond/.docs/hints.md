# Hints

## 1. Compute the Gigasecond anniversary date

- A Universal time is a number of seconds since the epoch.
- Common Lisp has a pair of functions which can encode or decode a 
universal time
- Multiple values from a function can be captured into a list with the use of the right macro.
- While the time-zone parameters of [`decode-universal-time`][hyperspec-decode-universal-time] and [`encode-universal-time`][hyperspec-encode-universla-time] is optional, it is important. What are their default values?

[hyperspec-decode-universal-time]: http://www.lispworks.com/documentation/HyperSpec/Body/f_dec_un.htm#decode-universal-time
[hyperspec-encode-universal-time]: http://www.lispworks.com/documentation/HyperSpec/Body/f_encode.htm#encode-universal-time
