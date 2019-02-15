#!/bin/sh
set -e

ROSWELL_TARBALL_PATH=$HOME/roswell.tar.gz
ROSWELL_DIR=$HOME/.roswell
ROSWELL_REPO=${ROSWELL_REPO:-https://github.com/roswell/roswell}
ROSWELL_BRANCH=${ROSWELL_BRANCH:-release}
ROSWELL_INSTALL_DIR=${ROSWELL_INSTALL_DIR:-/usr/local}
ROSWELL_PLATFORMHTML_BASE=${ROSWELL_PLATFORMHTML_BASE:-https://github.com/roswell/sbcl_bin/releases/download/files/build.html}
ROSWELL_SBCL_BIN_URI=${ROSWELL_SBCL_BIN_URI:-https://github.com/roswell/sbcl_bin/releases/download/}
ROSWELL_QUICKLISP_DIST_URI=${ROSWELL_QUICKLISP_DIST_URI:-http://beta.quicklisp.org/dist/quicklisp.txt}

LISP_IMPLS_BIN="$ROSWELL_INSTALL_DIR/bin"
LISP_IMPLS_DIR="$ROSWELL_DIR/impls/system"

log () {
    echo "$ $1"
    echo `$1`
}

fetch () {
    echo "Downloading $1..."
    if curl --no-progress-bar --retry 10 -o $2 -L $1; then
        return 0;
    else
        echo "Failed to download $1."
        exit 1
    fi
}

extract () {
    opt=$1
    file=$2
    destination=$3
    echo "Extracting a tarball $file into $destination..."
    mkdir -p "$destination"
    tar -C "$destination" --strip-components=1 "$opt" -xf "$file"
}

install_script () {
    path=$1; shift
    dir=$(dirname "$path")
    tmp=$(mktemp /tmp/rosci_XXX)

    echo "#!/bin/sh" > "$tmp"
    while [ "$1" != "" ]; do
        echo "$1" >> "$tmp"
        shift
    done
    chmod 755 "$tmp"
    mkdir -p "$dir" 2>/dev/null || $SUDO mkdir -p "$dir"

    if [ -w "$dir" ]; then
        mv "$tmp" "$path"
    else
        $SUDO mv "$tmp" "$path"
    fi
}

apt_installed_p () {
    if [ `uname` = "Darwin" ]; then
        if brew info "$1" |grep installed;then
            false
        else
            true
        fi
    else
        $(dpkg -s "$1" >/dev/null 2>&1)
    fi
}
apt_unless_installed () {
    if ! apt_installed_p "$1"; then
        if [ `uname` = "Darwin" ]; then
            brew install "$1"
        else
            $SUDO -E apt-get -yq update
            $SUDO -E apt-get -yq --no-install-suggests --no-install-recommends --force-yes install "$1"
        fi
    fi
}

install_abcl () {
    java=$(which java)
    if [ "$java" = "" ]; then
        if apt_installed_p "openjdk-7-jre"; then
            java="/usr/lib/jvm/java-7-openjdk/bin/java"
        elif apt_installed_p "openjdk-6-jre"; then
            java="/usr/lib/jvm/java-6-openjdk/bin/java"
        else
            apt_unless_installed openjdk-7-jre
            java="/usr/lib/jvm/java-7-openjdk/bin/java"
        fi
    fi
    PATH="$java:$PATH" ros install abcl-bin
    ros use abcl-bin
}

install_ecl () {
    if [ `uname` = "Darwin" ]; then
        brew install ecl
        ros use ecl/system
    else
        ros install ecl
        ros use ecl
    fi
}

if which sudo >/dev/null; then
    SUDO=sudo
fi

if ! which ros >/dev/null; then
    echo "Installing Roswell..."

    fetch "$ROSWELL_REPO/archive/$ROSWELL_BRANCH.tar.gz" "$ROSWELL_TARBALL_PATH"
    extract -z "$ROSWELL_TARBALL_PATH" "$ROSWELL_DIR"
    cd $ROSWELL_DIR
    sh bootstrap
    mkdir -p ~/.roswell
    echo "sbcl-bin-version-uri	0	$ROSWELL_PLATFORMHTML_BASE" >> ~/.roswell/config;
    echo "sbcl-bin-uri	0	$ROSWELL_SBCL_BIN_URI" >> ~/.roswell/config;
    ./configure --prefix=$ROSWELL_INSTALL_DIR
    make
    if [ -w "$ROSWELL_INSTALL_DIR" ]; then
        make install
    else
        $SUDO make install
    fi
    echo "Roswell has been installed."
else
    echo "Detected Roswell."
fi

case "$LISP" in
    alisp|allegro)
	apt_unless_installed libc6-i386
        LISP=allegro
        ;;
    cmu|cmucl|cmu-bin)
        apt_unless_installed libc6-i386
        LISP=cmu-bin
        ;;
    # 'ccl' is an alias for 'ccl-bin'
    ccl)
        LISP=ccl-bin
        ;;
    ccl32)
        LISP=ccl-bin
        apt_unless_installed libc6-i386
        ros config set ccl.bit 32
        ;;
    # 'sbcl-bin' is the default
    "")
        LISP=sbcl-bin
        ;;
esac

echo "Installing $LISP..."
case "$LISP" in
    clisp)
        if [ `uname` = "Darwin" ]; then
            apt_unless_installed clisp;
            ros use clisp/system;
        else
            ros install $LISP;
        fi
        ros install asdf;
        ;;
    abcl)
        install_abcl
        ;;
    ecl)
        install_ecl
        ;;
    sbcl-bin)
        ros use $LISP
        ;;
    *)
        ros install $LISP;
        ros use $LISP
        ;;
esac

log "ros version"
log "ros quicklisp.dist=$ROSWELL_QUICKLISP_DIST_URI setup"

if [ "$ROSWELL_LATEST_ASDF" ]; then
    echo "Installing the latest ASDF..."
    ros install asdf
fi

ros -e '(format t "~&~A ~A up and running! (ASDF ~A)~2%"
                (lisp-implementation-type)
                (lisp-implementation-version)
                #+asdf(asdf:asdf-version) #-asdf "not required")' || exit 1

# Setup ASDF source regisry
ASDF_SR_CONF_DIR="$HOME/.config/common-lisp/source-registry.conf.d"
ASDF_SR_CONF_FILE="$ASDF_SR_CONF_DIR/ci.conf"
LOCAL_LISP_TREE="$HOME/lisp"

mkdir -p "$ASDF_SR_CONF_DIR"
mkdir -p "$LOCAL_LISP_TREE"
if [ "$TRAVIS" ]; then
    echo "(:tree \"$TRAVIS_BUILD_DIR/\")" > "$ASDF_SR_CONF_FILE"
elif [ "$CIRCLECI" ]; then
    echo "(:tree \"$HOME/$CIRCLE_PROJECT_REPONAME/\")" > "$ASDF_SR_CONF_FILE"
fi
echo "(:tree \"$LOCAL_LISP_TREE/\")" >> "$ASDF_SR_CONF_FILE"
