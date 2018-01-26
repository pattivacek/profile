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
