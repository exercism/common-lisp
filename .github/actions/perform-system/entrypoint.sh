#!/bin/sh -ex

QUICKLISP_ADD_TO_INIT_FILE=true /usr/local/bin/install-quicklisp

LOCATION=\"$1\"
OPERATION=$2
SYSTEM=\"$3\"

/usr/local/bin/sbcl \
    --noinform --non-interactive \
    --eval "(push (merge-pathnames $LOCATION) asdf:*central-registry*)" \
    --eval "(ql:quickload $SYSTEM)" \
    --eval "(asdf:${OPERATION} $SYSTEM)"
