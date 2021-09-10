# Installation

## What's needed

The basic items needed for developing in Common Lisp are:

- A Lisp "Implementation", which will allow you to compile and execute code, as well as supply a REPL.
- A Text editor with facilities for Lisp code. 
- (Nice to have) The often-used reference for the Common Lisp language, the ["Common Lisp Hyperspec"][hyperspec].

## Fast Start

For people new to Common Lisp, particularly ones with previous experience with Emacs, can get an easy & quick start by installing [Portacle, the Portable Common Lisp Environment][portacle]. 
Free and full featured, it works in all common platforms and comes preconfigured "out of the box". This will supply:

- A Lisp implementation: SBCL, including Quicklisp and ASDF.
- A Text editor: Emacs

... with lots of add-ons for writing with Lisp code: 
- SLIME, the "Superior Lisp Interaction Mode for Emacs" turns Emacs into a Common Lisp IDE
- ParEdit, which makes working with parentheses easy. 

Everything comes already configured out of the box. Install Portacle by downloading from the [front page][portacle].

Note: Emacs (text editor) can be disorienting at first, if you're not accustomed to it. Fortunately there are many primers on Emacs and SLIME available online. 

## Traditional Start

If you prefer installing the needed tools separately you will need to install and set up:

- a Lisp-aware text editor: [Emacs][emacs] with the [Slime][slime] or [Sly][sly] package is a common choice but [VIM][vim] with [SLIMV][slimv], [Atom][atom] with [SLIMA][slima] or [VSCode][vscode] with a [Common Lisp plugin][vscode-plugin] are also good.
- a Common Lisp implementation: [SBCL][sbcl] is a "safe" choice which works across Linux, MacOS and Windows. Since the language is based upon a standard other [conforming implementations][awesome-cl-implementations] will work as well.
- [Quicklisp][quicklisp] for library management. After downloading it, follow the [instructions][quicklisp-install] to ensure it is properly integrated with your Common Lisp implementation.

[atom]: https://atom.io
[awesome-cl-implementations]: https://github.com/GustavBertram/awesome-common-lisp-learning#common-lisp-implementations
[emacs]: https://www.gnu.org/software/emacs/
[hyperspec]:  http://www.lispworks.com/documentation/HyperSpec/Front/Contents.htm
[portacle]: https://portacle.github.io/
[quicklisp]: http://www.quicklisp.org/beta/#installation
[quicklisp-install]: https://www.quicklisp.org/beta/#installation
[sbcl]: http://www.sbcl.org/
[slima]: https://atom.io/packages/slima
[slime]: https://common-lisp.net/project/slime/
[slimv]: https://github.com/kovisoft/slimv
[sly]: https://github.com/joaotavora/sly
[vim]: https://www.google.com/search?q=vim
[vscode-plugin]:  https://marketplace.visualstudio.com/items?itemName=ailisp.commonlisp-vscode
[vscode]:https://code.visualstudio.com
