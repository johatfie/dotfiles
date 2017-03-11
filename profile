# # ~/.profile: executed by the command interpreter for login shells.
# # This file is not read by bash(1), if ~/.bash_profile or ~/.bash_login
# # exists.
# # see /usr/share/doc/bash/examples/startup-files for examples.
# # the files are located in the bash-doc package.
#
# # the default umask is set in /etc/profile; for setting the umask
# # for ssh logins, install and configure the libpam-umask package.
# #umask 022
#
# export VIM=/usr/share/vim
# export VIMRUNTIME=/usr/share/vim/vim74
# export EDITOR=$VIM/vim
# export VISUAL=/usr/bin/gvim
#
# # # if running bash
# # if [ -n "$BASH_VERSION" ]; then
# #     # include .bashrc if it exists
# #     if [ -f "$HOME/.bashrc" ]; then
# # 	. "$HOME/.bashrc"
# #     fi
# # fi
#
# # set PATH so it includes user's private bin if it exists
# if [ -d "$HOME/bin" ] ; then
#     PATH="$HOME/bin:$PATH"
# fi
#
#
#
# if [ -d $HOME/.rvm/bin ] ; then
#     export PATH="$PATH:$HOME/.rvm/bin" # Add RVM to PATH for scripting
# fi
#
# [[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*
#
#
# echo "Running .profile"


# Set PATH so it includes user's private bin if it exists
if [ -d "${HOME}/bin" ] ; then
  PATH="${HOME}/bin:${PATH}"
fi

# Set PATH so it includes user's brew Applications folder if it exists
if [ -d "${HOME}/Applications" ] ; then
  PATH="${HOME}/Applications:${PATH}"
fi

if [ -d "/usr/local/bin" ] ; then
  PATH="/usr/local/bin:${PATH}"
fi

if [ -d "${HOME}/.bundler_binstubs" ] ; then
  PATH="~/.bundler_binstubs:${PATH}"
fi
#
# Add RVM to PATH for scripting
if [ -d "${HOME}/.rvm/bin" ] ; then
  PATH="${PATH}:$HOME/.rvm/bin"
fi

# Set MANPATH so it includes users' private man if it exists
if [ -d "${HOME}/man" ]; then
  MANPATH="${HOME}/man:${MANPATH}"
fi

# Set INFOPATH so it includes users' private info if it exists
if [ -d "${HOME}/info" ]; then
  INFOPATH="${HOME}/info:${INFOPATH}"
fi

# Load RVM into a shell session *as a function*
if [ -s "$HOME/.rvm/scripts/rvm" ] ; then
    source "$HOME/.rvm/scripts/rvm"
fi

#export PATH="/usr/local/sbin:$PATH"
#export PATH="$PATH | awk ' !x[$0]++'"

echo "$PATH"
export PATH
#export MANPATH
export INFOPATH



# Load RVM into a shell session *as a function*
if [ -s "$HOME/.rvm/scripts/rvm" ] ; then
  source "$HOME/.rvm/scripts/rvm"
fi

#export PATH=`echo -n $PATH | awk -v RS=: -v ORS=: '!arr[$0]++'`
echo "Running .profile"

#THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
export SDKMAN_DIR="/usr/home/jon/.sdkman"
[[ -s "/usr/home/jon/.sdkman/bin/sdkman-init.sh" ]] && source "/usr/home/jon/.sdkman/bin/sdkman-init.sh"
