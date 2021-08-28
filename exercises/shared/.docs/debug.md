# Debug

To help with debugging, you can use [`print` or similar functions][cl-print] to write to standard output which will be visible in the test output.

For example adding `(print "hello there")` into the function you are writing will cause it to be visible in the test runs (given that the test executes that function).

One "trick": if you have several things to print out is to collect them together in a list and then print that: `(print (list :this "that" 'the-other))`.

[cl-print]: http://www.lispworks.com/documentation/HyperSpec/Body/f_wr_pr.htm

