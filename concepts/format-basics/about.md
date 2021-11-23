# About

The Common Lisp Printer is the facility for outputting data to streams. One common function in this facility is `format`.

`format` takes two required parameters: a stream to write to and a control string. The contents of the control string determine how any further arguments are used.

The first parameter has two special values: `t` and `nil`. `t` indicates that the stream bound to `*standard-output*` should be used and `nil` indicates that a string should be created and returned. `format` evaluates to `nil` unless the stream parameter is `nil`.

The control string can contain format directives which are signified by a `~` followed by a character (the case of the character is not important). The format directive will define if any arguments are consumed and how they are formatted to the stream.

The important basic format directives are:

* `~A` - _aesthetically_ format in a "human readable" way.
* `~S` - format in the _standard_ to be "machine readable".
* `~%` - emit a newline
* `~&` - emit a newline unless already at the beginning of a line.
* `~~` - emit a tilde.

Examples:

```lisp
(format nil "The list is: ~A~%" (list 1 2 3)) ; => "The list is: (1 2 3)
                                                   "
(format nil "(format t ~S)" "hello world")    ; => "(format t \"hello world\""
(format nil "~&fresh~&lines")                 ;=> "fresh
                                                   lines"
(format nil "directives start with a ~~")     ; => "directives start with a ~"
```
