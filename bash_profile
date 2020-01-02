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

# Set PATH so it includes user's private bin if it exists
if [ -d "${HOME}/bin" ] ; then
  PATH="${HOME}/bin:${PATH}"
fi

# Set PATH so it includes user's brew Applications folder if it exists
if [ -d "${HOME}/Applications" ] ; then
  PATH="${HOME}/Applications:${PATH}"
fi

# Set MANPATH so it includes users' private man if it exists
if [ -d "${HOME}/man" ]; then
  MANPATH="${HOME}/man:${MANPATH}"
fi

# Set INFOPATH so it includes users' private info if it exists
if [ -d "${HOME}/info" ]; then
  INFOPATH="${HOME}/info:${INFOPATH}"
fi

[[ -s "$HOME/.profile" ]] && source "$HOME/.profile" # Load the default .profile

[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*

#if [ -d /usr/local/sbin ]; then
    #export PATH="/usr/local/sbin:$PATH"
#fi

test -e "${HOME}/.iterm2_shell_integration.bash" && source "${HOME}/.iterm2_shell_integration.bash"


# Appriss specific
export VAULT_ADDR=https://vault.hc.appriss.com
#export AWS_DEFAULT_PROFILE=adfs
export KUBECONFIG="${HOME}/.kube/lz_config"
export PATH="/usr/local/opt/postgresql@9.6/bin:$PATH"

# Set PATH so it includes AWS command line utilities
if [ -d "${HOME}/Applications" ] ; then
  PATH="${HOME}/Library/Python/3.7/bin:${PATH}"
fi

export PATH=/Library/PostgreSQL/9.6/bin:$PATH
export PGDATA=/Library/PostgreSQL/9.6/data
export PGDATABASE=postgres
export PGUSER=postgres
export PGPORT=5432
export PGLOCALEDIR=/Library/PostgreSQL/9.6/share/locale
export MANPATH=$MANPATH:/Library/PostgreSQL/9.6/share/man

eval "$(rbenv init -)"
eval "$(direnv hook bash)"

export NVM_DIR="$HOME/.nvm"
[ -s "/usr/local/opt/nvm/nvm.sh" ] && . "/usr/local/opt/nvm/nvm.sh"  # This loads nvm
[ -s "/usr/local/opt/nvm/etc/bash_completion.d/nvm" ] && . "/usr/local/opt/nvm/etc/bash_completion.d/nvm"  # This loads nvm bash_completion

# PATH=path | awk ' !x[$0]++'
export PATH=$(echo -n "$PATH" | awk -v RS=':' '(!a[$0]++){if(b++)printf(RS);printf($0)}')

echo "Running .bash_profile"

#THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
#export SDKMAN_DIR="/usr/home/jon/.sdkman"
#[[ -s "/usr/home/jon/.sdkman/bin/sdkman-init.sh" ]] && source "/usr/home/jon/.sdkman/bin/sdkman-init.sh"


# vim ft=sh
