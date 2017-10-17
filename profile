# ~/.profile: executed by the command interpreter for login shells.
# This file is not read by bash(1) if ~/.bash_profile or ~/.bash_login exists.
# See /usr/share/doc/bash/examples/startup-files for examples.
# The files are located in the bash-doc package.

if [ -n "${PROFILE_COMPLETE}" ]; then
    return 0
fi
export PROFILE_COMPLETE=yes

# The default umask is set in /etc/profile; for setting the umask for ssh
# logins, install and configure the libpam-umask package.
#umask 022

# If running bash
if [ -n "$BASH_VERSION" ]; then
    # Include .bashrc if it exists
    if [ -f "$HOME/.bashrc" ]; then
        . "$HOME/.bashrc"
    fi
fi

# Set PATH so it includes user's private bin if it exists
if [ -d "$HOME/bin" ] ; then
    PATH="$HOME/bin:$PATH"
fi

# I've never understood why this isn't in the path by default.
export PATH="${PATH}:/usr/sbin:/sbin"

export LD_LIBRARY_PATH="$LD_LIBRARY_PATH:/usr/local/lib:/usr/lib:/lib"

export EDITOR="vim"

####################################################
#function version_select # "/opt/depot/XXX"  "X.Y.Z"
#{
#    local PREFIX="$1"
#    local VERSION="$2"
#    if [ -z "$2" ]; then return; fi
#    # Don't select if nothing is available.
#    if [ ! -d "$PREFIX/$VERSION" ]; then return; fi
#    local PRODUCT=`basename $PREFIX`
#    if [ -d "$PREFIX/$VERSION/bin" ]; then
#	local CLEAN_PATH=`echo $PATH | sed s^$PREFIX/.*/bin^^g`
#	PATH="$PREFIX/$VERSION/bin:$PATH"
#    fi
#    if [ -d "$PREFIX/$VERSION/lib64" ]; then
#	local CLEAN_PATH=`echo $LD_LIBRARY_PATH | sed s^$PREFIX/.*/lib64^^g`
#	LD_LIBRARY_PATH="$PREFIX/$VERSION/lib64:$LD_LIBRARY_PATH"
#    elif [ -d "$PREFIX/$VERSION/lib" ]; then
#	local CLEAN_PATH=`echo $LD_LIBRARY_PATH | sed s^$PREFIX/.*/lib^^g`
#	LD_LIBRARY_PATH="$PREFIX/$VERSION/lib:$LD_LIBRARY_PATH"
#    fi
#    echo "Using $PRODUCT-$VERSION at $PREFIX/$VERSION"
#}
#
#function find_latest_version # /opt/depot/gcc
#{
#    ls --color=none "$1" | sort -r | head -n1
#}
#
#GCC_VER=`find_latest_version /opt/depot/gcc`
#version_select "/opt/depot/gcc" "$GCC_VER"
#
#IFORT_VER=`find_latest_version /opt/depot/intel`
#version_select "/opt/depot/intel" "$IFORT_VER"
####################################################

