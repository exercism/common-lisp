# Instructions

In this exercise you will write some code to help Larry the Lisp Alien parse and format log strings. These log strings come in from various systems and need to be processed so that their messages can be display on an informative monitoring display.

Log strings are in the form `"[<level>]: <message>"`. Level will be one of the following values: `info`, `warn`, or `ohno`.

## 1. Extract the message

Define a function `log-message` which will take a log string and evaluate to the message it contains.

```lisp
(log-message "[ohno]: whoops!") ; => "whoops!"
```

## 2. Determine the severity

The level of the log string determines its severity. 

- a level of `info` means a severity of `:everything-ok`
- a level of `warn` means a severity of `:getting-worried`
- a level of `ohno` means a severity of `:run-for-cover`

Define a function `log-severity` which will take a log string and evaluate to the correct severity.

```lisp
(log-severity "[warn]: might want to get that checked") ; => :getting-worried
```

## 3. Dealing with the vagaries of reality

Unfortunately sometimes the log strings are not always formatted correctly. Specifically the log level may be not all lower case as specified above. Modify `log-severity` to handle this.

```lisp
(log-severity "[WaRn]: string case system failing") ; => :getting-worried
```

## 4. Reformatting the log message according to log severity

Depending upon the severity the message should be modified in different ways:

- a severity of `:everything-ok` should have its message changed to all lower-case.
- a severity of `:getting-worried` should have its message changed to have each word capitalized.
- a severity of `:run-for-cover` should have its message changed to be all upper-case.

Define a function `log-format` that takes a log message and evaluates to a properly formatted message.

```lisp
(log-format "[ohno]: whoops!") ; => WHOOPS!
```

