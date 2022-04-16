# To the extent possible under law, the author(s) have dedicated all
# copyright and related and neighboring rights to this software to the
# public domain worldwide. This software is distributed without any warranty.
# You should have received a copy of the CC0 Public Domain Dedication along
# with this software.
# If not, see <http://creativecommons.org/publicdomain/zero/1.0/>.

# base-files version 4.2-4

# ~/.bash_profile: executed by bash(1) for login shells.

# The latest version as installed by the Cygwin Setup program can
# always be found at /etc/defaults/etc/skel/.bash_profile

# Modifying /etc/skel/.bash_profile directly will prevent
# setup from updating it.

# The copy in your home directory (~/.bash_profile) is yours, please
# feel free to customise it to create a shell
# environment to your liking.  If you feel a change
# would be benifitial to all, please feel free to send
# a patch to the cygwin mailing list.

# If not running interactively, don't do anything
[[ "$-" != *i* ]] && return


# User dependent .bash_profile file

# source the users bashrc if it exists
if [ -f "${HOME}/.bashrc" ] ; then
    source "${HOME}/.bashrc"
fi

# Set PATH so it includes Homebrew's sbin if it exists
if [ -d /usr/local/sbin ]; then
    export PATH="/usr/local/sbin:$PATH"
fi

# if [ -f "$(brew --prefix)/share/bash-completion/bash_completion" ]; then
#   . "$(brew --prefix)/share/bash-completion/bash_completion"
# fi

# Set PATH so it includes user's private bin if it exists
if [ -d "${HOME}/bin" ] ; then
    PATH="${HOME}/bin:${PATH}"
fi

# Set PATH so it includes user's brew Applications folder if it exists
if [ -d "${HOME}/Applications" ] ; then
    PATH="${HOME}/Applications:${PATH}"
fi

# Set PATH so it includes user's .jenv/bin folder if it exists
if [ -d "${HOME}/.jenv" ]; then
    PATH="$HOME/.jenv/bin:$PATH"
    eval "$(jenv init -)"
fi

# Set MANPATH so it includes users' private man if it exists
if [ -d "${HOME}/man" ]; then
    MANPATH="${HOME}/man:${MANPATH}"
    export MANPATH
fi

# Set INFOPATH so it includes users' private info if it exists
if [ -d "${HOME}/info" ]; then
    INFOPATH="${HOME}/info:${INFOPATH}"
    export INFOPATH
fi

[[ -s "$HOME/.profile" ]] && source "$HOME/.profile" # Load the default .profile

[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*

test -e "${HOME}/.iterm2_shell_integration.bash" && source "${HOME}/.iterm2_shell_integration.bash"



# Remove duplicates from PATH
# export PATH=$(echo -n "$PATH" | awk -v RS=':' '(!a[$0]++){if(b++)printf(RS);printf($0)}')
export PATH=$(echo -n "$PATH" | sed -e 's/%\([^%]*\)%/$\1/g' | awk -v RS=':' '(!a[$0]++){if(b++)printf(RS);printf($0)}' | envsubst)

# Remove duplicates from PATH
#export PATH=$(echo -n "$PATH" | sed -e 's/%\([^%]*\)%/$($\1)/g' | awk -v RS=':' '(!a[$0]++){if(b++)printf(RS);printf($0)}')

echo "Running .bash_profile"


# vim ft=bash
